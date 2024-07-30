import 'dart:async';
import 'dart:io';

import 'package:saharin/src/models/requests/user_logout_request.dart';
import 'package:saharin/src/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  updateUser(UserData? userData) => state =
      state.copyWith(authUser: userData, email: userData?.userData.email);

  fetchUserDetails() async {
    if (!await hasInternetAccess()) {
      showErrorMessage("No Internet Connection");
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    final token = ref
        .read(sharedPreferencesProvider)
        .getString(PreferenceService.authToken);
    if (token == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    } else {
      debugPrint(token);
      final res = await apiService.fetchUserDetails(token: token);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(status: AuthStatus.unauthenticated);
        return;
      } else {
        state = state.copyWith(
            authUser: UserData(userData: res.data!, token: token, time: '24h'));
        state = state.copyWith(status: AuthStatus.authenticated);
      }
    }
  }

  Future<String> logOut() async {
    if (!await hasInternetAccess()) {
      return "No Internet Connection!";
    }
    try {
      final deviceId = await getId();
      final res = await apiService.logOut(
          userLogoutRequest: UserLogoutRequest(
              deviceId: deviceId, id: state.authUser?.userData.id ?? ""));
      if (res.status != ApiStatus.success) {
        return res.errorMessage ?? "Something Went Wrong!!!";
      }
      ref
          .read(sharedPreferencesProvider)
          .setString(PreferenceService.authToken, "");
      GoogleSignIn().disconnect();
      state = state.copyWith(
          authUser: null,
          status: AuthStatus.unauthenticated,
          email: null,
          password: null);
      return "";
    } catch (e) {
      state = state.copyWith(
          authUser: null,
          status: AuthStatus.unauthenticated,
          email: null,
          password: null);
      ref
          .read(sharedPreferencesProvider)
          .setString(PreferenceService.authToken, "");
      GoogleSignIn().disconnect();
      changeState(AuthStatus.unauthenticated);
      return e.toString();
    }
  }

  Future<String> loginUser() async {
    try {
      if (!await hasInternetAccess()) {
        return "No Internet Connection";
      }
      String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      RegExp regex = RegExp(emailPattern);
      if (!regex.hasMatch(state.email ?? "")) {
        return "Please enter valid email";
      }
      final deviceId = await getId();
      final res = await apiService.loginUser(
          userLoginRequest: UserLoginRequest(
              email: state.email!,
              password: state.password!,
              fcmToken: '*',
              deviceId: deviceId,
              os: Platform.isAndroid ? 'android' : "ios"));

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
        state = state.copyWith(authUser: res.data);
        if (state.checkbox) {
          ref
              .read(sharedPreferencesProvider)
              .setString(PreferenceService.authToken, res.data?.token ?? "");
        }
        if (res.data?.userData.isEmailVerified != 0) {
          changeState(AuthStatus.authenticated);
        } else {
          changeState(AuthStatus.authenticatedNotVerified);
        }
        return '';
      }

      return '';
    } catch (e) {
      ref
          .read(sharedPreferencesProvider)
          .setString(PreferenceService.authToken, "");
      try {
        GoogleSignIn().disconnect();
      } catch (e) {
        // return e.toString()
      }

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
