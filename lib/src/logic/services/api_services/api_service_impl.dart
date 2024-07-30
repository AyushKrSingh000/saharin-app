// 📦 Package imports:

// 🌎 Project imports:

import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/requests/user_logout_request.dart';
import 'package:saharin/src/models/user_data.dart';
import 'package:saharin/src/models/user_register_data.dart';
import 'package:dio/dio.dart';

import '../../../models/api_response.dart';
import '../../../models/requests/social_login_request.dart';
import '../../../utils/network_utils.dart';
import 'api_service.dart';
import 'retrofit/auth_api_client/auth_api_client.dart';

class ApiServiceImpl extends ApiService {
  late final Dio dio;
  late final AuthApiClient _authApiClient;

  late final String baseUrl;

  ApiServiceImpl() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 200000),
      ),
    );
    _authApiClient = AuthApiClient(dio);
  }

  @override
  Future<ApiResponse<UserData>> registerUser({
    required UserRegisterData userData,
  }) async {
    try {
      final response = await _authApiClient.registerUser(
        userRegisterData: userData,
      ) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      }
      if (response['message'] == 'This email is already occupied') {
        return ApiResponse.error('This email is already occupied');
      } else if (response['status'] == true) {
        return ApiResponse.success(UserData.fromJson(response['data']));
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Sonmething Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<UserData>> loginUser({
    required UserLoginRequest userLoginRequest,
  }) async {
    try {
      final response = await _authApiClient.loginUser(
        userLoginRequest: userLoginRequest,
      ) as Map<String, dynamic>;

      if (response['status'] == false) {
        return ApiResponse<UserData>.error(
            response['message'] ?? "Something Went Wrong!");
      }

      return ApiResponse<UserData>.success(UserData.fromJson(response['data']));
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse<UserData>.noInternet();
      }
      return ApiResponse<UserData>.error(
          e.response?.data['message'] ?? "Something Went Wrong");
    }
  }

  @override
  Future<ApiResponse<String>> sendOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  }) async {
    try {
      final response = await _authApiClient.sendEmailOtp(
          sendEmailOtpRequest: sendEmailOtpRequest) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success(response['message']);
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Sonmething Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<String>> updateEmailOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  }) async {
    try {
      final response = await _authApiClient.updateEmailOtp(
          sendEmailOtpRequest: sendEmailOtpRequest) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success("");
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Something Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<String>> verifyOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  }) async {
    try {
      final response = await _authApiClient.verifyOtp(
          sendEmailOtpRequest: sendEmailOtpRequest) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success("");
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Something Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<UserLoggedData>> fetchUserDetails({
    required String token,
  }) async {
    try {
      final response = await _authApiClient.fetchUserDetails(
        token: token,
      ) as Map<String, dynamic>;

      if (response['status'] == false) {
        return ApiResponse<UserLoggedData>.error(
            response['message'] ?? "Something Went Wrong!");
      }

      return ApiResponse<UserLoggedData>.success(
          UserLoggedData.fromJson(response['data']));
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Something Went Wrong");
    }
  }

  @override
  Future<ApiResponse<UserData>> socialLogin({
    required SocialLoginRequest socialLoginRequest,
  }) async {
    try {
      final response = await _authApiClient.soicalLogin(
        socialLoginRequest: socialLoginRequest,
      ) as Map<String, dynamic>;

      if (response['status'] == false) {
        return ApiResponse<UserData>.error(
            response['message'] ?? "Something Went Wrong!");
      }

      return ApiResponse<UserData>.success(UserData.fromJson(response['data']));
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse<UserData>.noInternet();
      }
      if (e.response?.data['message'].runtimeType.toString() ==
          "_Map<String, dynamic>") {
        return ApiResponse.error("Server did not respond. Try Again!!!");
      }
      return ApiResponse<UserData>.error(
          e.response?.data['message'] ?? "Something Went Wrong");
    }
  }

  @override
  Future<ApiResponse<String>> sendForgotPassOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  }) async {
    try {
      final response = await _authApiClient.sendChangePassOtp(
          sendEmailOtpRequest: sendEmailOtpRequest) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success(response['message'] ?? "");
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Sonmething Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<String>> changePassword({
    required SendEmailOtpRequest sendEmailOtpRequest,
  }) async {
    try {
      final response = await _authApiClient.changePassword(
          sendEmailOtpRequest: sendEmailOtpRequest) as Map<String, dynamic>;
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success(response['message'] ?? "");
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Sonmething Went Wrong!!!");
    }
  }

  @override
  Future<ApiResponse<String>> logOut({
    required UserLogoutRequest userLogoutRequest,
  }) async {
    try {
      final response = await _authApiClient.logOut(
          userLogoutRequest: userLogoutRequest) as Map<String, dynamic>;
      // print(response);
      if (response['status'] == false) {
        return ApiResponse.error(
            response['message'] ?? "Something Went Wrong!");
      } else if (response['status'] == true) {
        return ApiResponse.success(response['message']);
      } else {
        return ApiResponse.error('Something Went Wrong');
      }
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      return ApiResponse.error(
          e.response?.data['message'] ?? "Sonmething Went Wrong!!!");
    }
  }
}
