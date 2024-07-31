import 'package:saharin/src/models/insurance_requests_data/insurance_requests_data.dart';
import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/api_response.dart';
import '../../../models/insurance_plan_data/insurance_plan_data.dart';
import '../../../models/insurance_provider_data/insurance_provider_data.dart';
import '../../../models/loan_request_data/loan_request_data.dart';
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
  Future<ApiResponse<UserData>> loginSHGUser({
    required UserLoginRequest userLoginRequest,
  });
  Future<ApiResponse<UserData>> loginInsuranceProvider({
    required UserLoginRequest userLoginRequest,
  });
  Future<ApiResponse<List<InsurancePlanData>>> getAllInsurances({
    required String token,
  });
  Future<ApiResponse<List<InsuranceProviderData>>> getAllInsuranceProvider({
    required String token,
  });
  Future<ApiResponse<List<InsuranceRequestsData>>> getInsuranceRequests({
    required String token,
  });
  Future<ApiResponse<List<LoanRequestData>>> getloanRequests({
    required String token,
  });
  Future<ApiResponse<String>> changePassword({
    required SendEmailOtpRequest sendEmailOtpRequest,
  });

  Future<ApiResponse<String>> logOut({
    required UserLogoutRequest userLogoutRequest,
  });

  // basic-api's
}
