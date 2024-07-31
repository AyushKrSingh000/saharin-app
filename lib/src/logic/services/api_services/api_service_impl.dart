// 📦 Package imports:

// 🌎 Project imports:

// ignore_for_file: unused_import

import 'package:saharin/src/models/insurance_plan_data/insurance_plan_data.dart';
import 'package:saharin/src/models/insurance_provider_data/insurance_provider_data.dart';
import 'package:saharin/src/models/insurance_requests_data/insurance_requests_data.dart';
import 'package:saharin/src/models/requests/send_email_otp_request.dart';
import 'package:saharin/src/models/requests/user_login_request.dart';
import 'package:saharin/src/models/requests/user_logout_request.dart';
import 'package:saharin/src/models/user_data.dart';
import 'package:saharin/src/models/user_register_data.dart';
import 'package:dio/dio.dart';

import '../../../models/api_response.dart';
import '../../../models/loan_request_data/loan_request_data.dart';
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
  Future<ApiResponse<UserData>> loginSHGUser({
    required UserLoginRequest userLoginRequest,
  }) async {
    try {
      final response = await _authApiClient.loginSHGUser(
        userLoginRequest: userLoginRequest,
      ) as Map<String, dynamic>;

      if (response['status'] != 'success') {
        return ApiResponse<UserData>.error("Something Went Wrong!");
      }
      print(response);
      return ApiResponse<UserData>.success(UserData.fromJson(response));
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
  Future<ApiResponse<UserData>> loginInsuranceProvider({
    required UserLoginRequest userLoginRequest,
  }) async {
    try {
      final response = await _authApiClient.loginInsuranceProvider(
          userLoginRequest: userLoginRequest) as Map<String, dynamic>;
      if (response['status'] != 'success') {
        return ApiResponse.error("Something Went Wrong!");
      } else if (response['status'] == 'success') {
        return ApiResponse.success(UserData.fromJson(response));
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
  Future<ApiResponse<List<InsurancePlanData>>> getAllInsurances({
    required String token,
  }) async {
    try {
      final response = await _authApiClient.getAllInsurance(
          token: 'Bearer $token') as Map<String, dynamic>;

      return ApiResponse.success((response['insurancePlans'] as List)
          .map((e) => InsurancePlanData.fromJson(e))
          .toList());
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
  Future<ApiResponse<List<InsuranceProviderData>>> getAllInsuranceProvider({
    required String token,
  }) async {
    try {
      final response = await _authApiClient.getAllInsuranceProvider(
        token: 'Bearer $token',
      ) as Map<String, dynamic>;

      return ApiResponse<List<InsuranceProviderData>>.success(
          (response['insuranceProviders'] as List)
              .map((e) => InsuranceProviderData.fromJson(e))
              .toList());
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      print(e.response?.data.toString());
      return ApiResponse.error("Something Went Wrong");
    }
  }

  @override
  Future<ApiResponse<List<InsuranceRequestsData>>> getInsuranceRequests({
    required String token,
  }) async {
    try {
      final response = await _authApiClient.getInsuranceRequests(
        token: 'Bearer $token',
      ) as Map<String, dynamic>;

      return ApiResponse<List<InsuranceRequestsData>>.success(
          (response['insuranceRequests'] as List)
              .map((e) => InsuranceRequestsData.fromJson(e))
              .toList());
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      print(e.response?.data.toString());
      return ApiResponse.error("Something Went Wrong");
    }
  }

  @override
  Future<ApiResponse<List<LoanRequestData>>> getloanRequests({
    required String token,
  }) async {
    try {
      final response = await _authApiClient.getLoanRequests(
        token: 'Bearer $token',
      ) as Map<String, dynamic>;

      return ApiResponse<List<LoanRequestData>>.success(
          (response['loanRequests'] as List)
              .map((e) => LoanRequestData.fromJson(e))
              .toList());
    } on DioException catch (e) {
      final hasInternet = await hasInternetAccess();
      if (!hasInternet) {
        return ApiResponse.noInternet();
      }
      print(e.response?.data.toString());
      return ApiResponse.error("Something Went Wrong");
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
