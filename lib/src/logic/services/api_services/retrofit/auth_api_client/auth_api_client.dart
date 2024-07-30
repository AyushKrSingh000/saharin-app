import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/requests/user_logout_request.dart';
import 'package:saharin/src/models/user_register_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/requests/social_login_request.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: 'http://localhost:5000/')
abstract class AuthApiClient {
  factory AuthApiClient(
    Dio dio, {
    String baseUrl,
  }) = _AuthApiClient;

  @POST('/auth/register')
  Future registerUser({
    @Body() required UserRegisterData userRegisterData,
  });
  @POST('/auth/login')
  Future loginUser({
    @Body() required UserLoginRequest userLoginRequest,
  });
  @POST('/auth/send_email_otp')
  Future sendEmailOtp({
    @Body() required SendEmailOtpRequest sendEmailOtpRequest,
  });
  @POST('/auth/update_email_otp')
  Future updateEmailOtp({
    @Body() required SendEmailOtpRequest sendEmailOtpRequest,
  });
  @POST('/auth/get_user_from_token')
  Future fetchUserDetails({
    @Header('Authorization') required String token,
  });
  @POST('/auth/social_login')
  Future soicalLogin({
    @Body() required SocialLoginRequest socialLoginRequest,
  });
  @POST('/auth/forgot')
  Future sendChangePassOtp({
    @Body() required SendEmailOtpRequest sendEmailOtpRequest,
  });
  @POST('/auth/reset_password')
  Future changePassword({
    @Body() required SendEmailOtpRequest sendEmailOtpRequest,
  });
  @POST('/auth/verify_otp')
  Future verifyOtp({
    @Body() required SendEmailOtpRequest sendEmailOtpRequest,
  });
  @POST('/auth/logout')
  Future logOut({
    @Body() required UserLogoutRequest userLogoutRequest,
  });
}
