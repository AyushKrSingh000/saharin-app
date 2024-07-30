import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/requests/user_logout_request.dart';
import 'package:saharin/src/models/user_register_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/requests/social_login_request.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: 'http://localhost:8000/')
abstract class AuthApiClient {
  factory AuthApiClient(
    Dio dio, {
    String baseUrl,
  }) = _AuthApiClient;

  @POST('/auth/register')
  Future registerUser({
    @Body() required UserRegisterData userRegisterData,
  });
  @POST('/api/v1/selfHelpGroup/login')
  Future loginSHGUser({
    @Body() required UserLoginRequest userLoginRequest,
  });
  @POST('api/v1/insuranceProvider/login')
  Future loginInsuranceProvider({
    @Body() required UserLoginRequest userLoginRequest,
  });
  @GET('/api/v1/selfHelpGroup/insurancePlans')
  Future getAllInsurance({
    @Header('jwt') required String token,
  });
  @GET('/api/v1/selfHelpGroup/insuranceProviders')
  Future getAllInsuranceProvider({
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
