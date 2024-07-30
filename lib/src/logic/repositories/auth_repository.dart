import 'dart:async';

import 'package:saharin/src/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/api_response.dart';
import '../../models/requests/user_login_request.dart';
import '../../models/user_data.dart';

import '../../utils/network_utils.dart';
import '../services/api_services/api_service.dart';
import '../services/preference_services.dart';

part 'auth_repository.freezed.dart';

final authRepositoryProvider = StateNotifierProvider<AuthRepository, AuthState>(
  (ref) => AuthRepository(
    apiService: ref.read(apiServiceProvider),
    preferenceService: ref.read(preferenceServiceProvider),
    ref: ref,
  ),
);

class AuthRepository extends StateNotifier<AuthState> {
  final ApiService apiService;
  late final StreamSubscription _subscription;
  final PreferenceService preferenceService;
  final StateNotifierProviderRef ref;

  AuthRepository({
    required this.apiService,
    required this.preferenceService,
    required this.ref,
  }) : super(const AuthState()) {
    fetchUserDetails();
  }
  updateUser(UserData? userData) => state = state.copyWith(
      authUser: userData,
      email: userData?.data.user.email,
      idToken: userData?.token);

  fetchUserDetails() async {
    if (!await hasInternetAccess()) {
      showErrorMessage("No Internet Connection");
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  Future<String> loginSHGUser(String email, String password) async {
    try {
      if (!await hasInternetAccess()) {
        return "No Internet Connection";
      }
      String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      RegExp regex = RegExp(emailPattern);
      if (!regex.hasMatch(email)) {
        return "Please enter valid email";
      }

      final res = await apiService.loginSHGUser(
          userLoginRequest: UserLoginRequest(
        email: email.trim(),
        password: password.trim(),
      ));

      if (res.status != ApiStatus.success) {
        return res.errorMessage ?? "Something Went Wrong";
      } else {
        if (mounted) {
          state = state.copyWith(
            authUser: res.data,
            idToken: res.data!.token,
            status: AuthStatus.authenticated,
          );
        }
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> loginProvider(String email, String password) async {
    try {
      if (!await hasInternetAccess()) {
        return "No Internet Connection";
      }
      // String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      // // RegExp regex = RegExp(emailPattern);
      // // if (!regex.hasMatch(email ?? "")) {
      // //   return "Please enter valid email";
      // // }
      final res = await apiService.loginInsuranceProvider(
          userLoginRequest: UserLoginRequest(
        email: email.trim(),
        password: password.trim(),
      ));

      if (res.status != ApiStatus.success) {
        return res.errorMessage ?? "Something Went Wrong";
      } else {
        if (mounted) {
          state = state.copyWith(authUser: res.data, idToken: res.data!.token);
          changeState(AuthStatus.authenticated);
        }
      }

      return '';
    } catch (e) {
      ref
          .read(sharedPreferencesProvider)
          .setString(PreferenceService.authToken, "");

      return e.toString();
    }
  }

  signOut() {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      authUser: null,
      idToken: null,
    );
  }

  setInternetConnectedStatus() {
    state = state.copyWith(
      status: state.idToken != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated,
    );
  }

  setEmail(String email) => state = state.copyWith(email: email);
  setPass(String pass) => state = state.copyWith(password: pass);
  setCheckBox(bool checkbox) => state = state.copyWith(checkbox: checkbox);
  changeState(AuthStatus authStatus) {
    state = state.copyWith(status: authStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(null) UserData? authUser,
    @Default(null) String? idToken,
    @Default(null) String? email,
    @Default(null) String? password,
    @Default(false) bool checkbox,
    @Default(AuthStatus.initial) AuthStatus status,
  }) = _AuthState;
}

enum AuthStatus {
  initial,
  unauthenticated,
  authenticatedNotVerified,
  authenticated,
  noInternet,
}
