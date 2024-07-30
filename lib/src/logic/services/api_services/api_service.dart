import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/api_response.dart';
import '../../../models/requests/social_login_request.dart';
import '../../../models/requests/user_logout_request.dart';
import '../../../models/user_register_data.dart';
import 'api_service_impl.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiServiceImpl(),
);

abstract class ApiService {
  //auth-api's
  Future<ApiResponse<UserData>> registerUser({
    required UserRegisterData userData,
  });
  Future<ApiResponse<UserData>> loginUser({
    required UserLoginRequest userLoginRequest,
  });
  Future<ApiResponse<String>> sendOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });
  Future<ApiResponse<String>> updateEmailOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });
  Future<ApiResponse<UserLoggedData>> fetchUserDetails({
    required String token,
  });
  Future<ApiResponse<UserData>> socialLogin({
    required SocialLoginRequest socialLoginRequest,
  });
  Future<ApiResponse<String>> sendForgotPassOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });
  Future<ApiResponse<String>> changePassword({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });

  Future<ApiResponse<String>> verifyOtp({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });
  Future<ApiResponse<String>> logOut({
    required UserLogoutRequest userLogoutRequest,
  });

  // basic-api's
}
