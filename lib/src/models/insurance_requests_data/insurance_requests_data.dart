import 'package:json_annotation/json_annotation.dart';

part 'insurance_requests_data.g.dart';

@JsonSerializable()
class InsuranceRequestsData {
  @JsonKey(name: '_id')
  final String id;
  final String selfHelpGroup;
  final String insuranceProvider;
  final String insurancePlan;
  final String status;
  final String? agent;

  InsuranceRequestsData({
    required this.id,
    required this.selfHelpGroup,
    required this.insuranceProvider,
    required this.insurancePlan,
    required this.status,
    this.agent,
  });

  factory InsuranceRequestsData.fromJson(Map<String, dynamic> json) {
    return _$InsuranceRequestsDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InsuranceRequestsDataToJson(this);
}
