// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:saharin/src/logic/repositories/auth_repository.dart';
import 'package:saharin/src/models/insurance_plan_data/insurance_plan_data.dart';
import 'package:saharin/src/models/insurance_provider_data/insurance_provider_data.dart';
import 'package:saharin/src/utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../logic/services/api_services/api_service.dart';
import '../../models/api_response.dart';

part 'home_tab_page_model.freezed.dart';

final homeTabPageModelProvider =
    StateNotifierProvider.autoDispose<HomeTabPageModel, HomeTabPageState>(
  (ref) => HomeTabPageModel(
    ref: ref,
    apiService: ref.read(apiServiceProvider),
  ),
);

class HomeTabPageModel extends StateNotifier<HomeTabPageState> {
  final ApiService apiService;
  final StateNotifierProviderRef ref;

  HomeTabPageModel({
    required this.apiService,
    required this.ref,
  }) : super(const HomeTabPageState()) {
    Future.delayed(Duration.zero, () async {
      await init();
    });
  }
  getInsuranceProviders() async {
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: HomePageStatus.error,
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
          status: HomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          status: HomePageStatus.loaded,
          insuranceProviders: res.data ?? [],
        );
      }
      return;
    } catch (e) {
      state = state.copyWith(
        status: HomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }

  init() async {
    state = state.copyWith(
      errorMessage: '',
      status: HomePageStatus.loading,
    );
    try {
      if (!await hasInternetAccess()) {
        state = state.copyWith(
          status: HomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: "No Internet Connection!!!",
        );
        return;
      }
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));
      final res = await apiService.getAllInsurances(token: token!);
      if (res.status != ApiStatus.success) {
        state = state.copyWith(
          status: HomePageStatus.error,
          insuranceData: [],
          insuranceProviders: [],
          errorMessage: res.errorMessage ?? "Something Went Wrong!!!",
        );
      }

      if (mounted) {
        state = state.copyWith(
          errorMessage: "",
          insuranceData: res.data ?? [],
        );
      }
      await getInsuranceProviders();
      return;
    } catch (e) {
      state = state.copyWith(
        status: HomePageStatus.error,
        insuranceData: [],
        insuranceProviders: [],
        errorMessage: e.toString(),
      );
    }
  }
}

@freezed
class HomeTabPageState with _$HomeTabPageState {
  const factory HomeTabPageState({
    @Default('') String errorMessage,
    @Default([]) List<InsurancePlanData> insuranceData,
    @Default([]) List<InsuranceProviderData> insuranceProviders,
    @Default(HomePageStatus.initial) HomePageStatus status,
  }) = _HomeTabPageState;
}

enum HomePageStatus {
  initial,
  loading,
  loaded,
  error,
}
