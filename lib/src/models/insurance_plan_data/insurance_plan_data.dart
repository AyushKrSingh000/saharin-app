import 'package:json_annotation/json_annotation.dart';

part 'insurance_plan_data.g.dart';

@JsonSerializable()
class InsurancePlanData {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int premium;
  final int coverage;
  final String insuranceProvider;

  InsurancePlanData({
    required this.id,
    required this.name,
    required this.premium,
    required this.coverage,
    required this.insuranceProvider,
  });

  factory InsurancePlanData.fromJson(Map<String, dynamic> json) {
    return _$InsurancePlanDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InsurancePlanDataToJson(this);
}
