// ignore_for_file: public_member_api_docs, sort_constructors_first, empty_catches

import 'dart:io';
import 'package:saharin/src/logic/repositories/auth_repository.dart';
import 'package:saharin/src/logic/services/preference_services.dart';

import 'package:saharin/src/models/api_response.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/utils/network_utils.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../logic/services/api_services/api_service.dart';

part 'signin_model.freezed.dart';

final signInPageModelProvider =
    StateNotifierProvider.autoDispose<SignInPageModel, SignInPageState>(
  (ref) => SignInPageModel(
    ref: ref,
    apiService: ref.read(apiServiceProvider),
  ),
);

class SignInPageModel extends StateNotifier<SignInPageState> {
  final ApiService apiService;
  final StateNotifierProviderRef ref;

  SignInPageModel({
    required this.apiService,
    required this.ref,
  }) : super(const SignInPageState());

  setEmail(String email) => state = state.copyWith(email: email);

  setPassword(String password) => state = state.copyWith(password: password);

  Future<String> loginUser(
      {required bool checkBox, String? email, String? password}) async {
    try {
      if (!await hasInternetAccess()) {
        return "No Internet Connection";
      }
      String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      RegExp regex = RegExp(emailPattern);
      if (!regex.hasMatch(state.email)) {
        return "Please enter valid email";
      }
      final deviceId = await getId();
      final res = await apiService.loginUser(
          userLoginRequest: UserLoginRequest(
              email: email ?? state.email,
              password: password ?? state.password,
              fcmToken: '*',
              deviceId: deviceId,
              os: Platform.isAndroid ? 'android' : "ios"));
      ref.read(authRepositoryProvider.notifier).setEmail(state.email);
      ref.read(authRepositoryProvider.notifier).setPass(state.password);
      if (res.status != ApiStatus.success) {
        if (mounted) {
          if (res.errorMessage == 'Email not verified') {
            ref
                .read(authRepositoryProvider.notifier)
                .changeState(AuthStatus.authenticatedNotVerified);
            return "";
          }
          return res.errorMessage ?? "Something Went Wrong";
        }
      } else {
        ref.read(authRepositoryProvider.notifier).updateUser(res.data);

        if (checkBox) {
          ref
              .read(sharedPreferencesProvider)
              .setString(PreferenceService.authToken, res.data?.token ?? "");
        }
        if (res.data?.userData.isEmailVerified != 0) {
          ref
              .read(authRepositoryProvider.notifier)
              .changeState(AuthStatus.authenticated);
        } else {
          ref
              .read(authRepositoryProvider.notifier)
              .changeState(AuthStatus.authenticatedNotVerified);
        }

        return '';
      }

      return '';
    } catch (e) {
      return e.toString();
    }
  }

  addInd(int ind) {
    state = state.copyWith(removedInd: state.removedInd.toList()..add(ind));
  }

  // Future<void> _updateLoginInfo(FacebookLogin plugin) async {
  //   final token = await plugin.accessToken;
  //   FacebookUserProfile? profile;
  //   String? email;
  //   String? imageUrl;

  //   if (token != null) {
  //     profile = await plugin.getUserProfile();
  //     if (token.permissions.contains(FacebookPermission.email.name)) {
  //       email = await plugin.getUserEmail();
  //     }
  //     imageUrl = await plugin.getProfileImageUrl(width: 100);
  //   }
  //   print(email);
  // }
}

@freezed
class SignInPageState with _$SignInPageState {
  const factory SignInPageState({
    @Default('') String email,
    @Default('') String password,
    @Default([]) List<int> removedInd,
  }) = _SignInPageState;
}
