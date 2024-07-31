// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:saharin/src/logic/repositories/auth_repository.dart';
import 'package:saharin/src/models/insurance_plan_data/insurance_plan_data.dart';
import 'package:saharin/src/models/insurance_provider_data/insurance_provider_data.dart';
import 'package:saharin/src/models/insurance_requests_data/insurance_requests_data.dart';
import 'package:saharin/src/utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../logic/services/api_services/api_service.dart';
import '../../../models/api_response.dart';
import '../../../models/loan_request_data/loan_request_data.dart';

part 'provider_home_tab_model.freezed.dart';

final providerHomeTabPageModelProvider = StateNotifierProvider.autoDispose<
    ProviderHomeTabPageModel, ProviderHomeTabPageState>(
  (ref) => ProviderHomeTabPageModel(
    ref: ref,
    apiService: ref.read(apiServiceProvider),
  ),
);

class ProviderHomeTabPageModel extends StateNotifier<ProviderHomeTabPageState> {
  final ApiService apiService;
  final StateNotifierProviderRef ref;

  ProviderHomeTabPageModel({
    required this.apiService,
    required this.ref,
  }) : super(const ProviderHomeTabPageState()) {
    Future.delayed(Duration.zero, () async {
      await init();
    });
  }
  getInsuranceProviders() async {
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: "No Internet Connection!!!",
        );
        return;
      }
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));

      final res = await apiService.getAllInsuranceProvider(token: token!);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          // status: ProviderHomePageStatus.loaded,
          insuranceProviders: res.data ?? [],
        );
        await getInsuranceRequests();
      }
      return;
    } catch (e) {
      state = state.copyWith(
        status: ProviderHomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }

  getLoanRequests() async {
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: "No Internet Connection!!!",
        );
        return;
      }
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));

      final res = await apiService.getAllInsuranceProvider(token: token!);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          status: ProviderHomePageStatus.loaded,
          insuranceProviders: res.data ?? [],
        );
      }
      return;
    } catch (e) {
      state = state.copyWith(
        status: ProviderHomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }

  getInsuranceRequests() async {
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: "No Internet Connection!!!",
        );
        return;
      }
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));

      final res = await apiService.getInsuranceRequests(token: token!);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          // status: ProviderHomePageStatus.loaded,
          insuranceRequests: res.data ?? [],
        );
        await getLoanRequests();
      }

      return;
    } catch (e) {
      state = state.copyWith(
        status: ProviderHomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }

  init() async {
    state = state.copyWith(
      errorMessage: '',
      status: ProviderHomePageStatus.loading,
    );
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: "No Internet Connection!!!",
        );
        return;
      }
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));
      final res = await apiService.getloanRequests(token: token!);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          status: ProviderHomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          loanRequests: res.data ?? [],
        );
      }
      await getInsuranceProviders();
      return;
    } catch (e) {
      state = state.copyWith(
        status: ProviderHomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }
}

@freezed
class ProviderHomeTabPageState with _$ProviderHomeTabPageState {
  const factory ProviderHomeTabPageState({
    @Default('') String errorMessage,
    @Default([]) List<InsurancePlanData> insuranceData,
    @Default([]) List<InsuranceProviderData> insuranceProviders,
    @Default([]) List<InsuranceRequestsData> insuranceRequests,
    @Default([]) List<LoanRequestData> loanRequests,
    @Default(ProviderHomePageStatus.initial) ProviderHomePageStatus status,
  }) = _ProviderHomeTabPageState;
}

enum ProviderHomePageStatus {
  initial,
  loading,
  loaded,
  error,
}
