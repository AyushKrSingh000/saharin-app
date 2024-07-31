// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_requests_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceRequestsData _$InsuranceRequestsDataFromJson(
        Map<String, dynamic> json) =>
    InsuranceRequestsData(
      id: json['_id'] as String,
      selfHelpGroup: json['selfHelpGroup'] as String,
      insuranceProvider: json['insuranceProvider'] as String,
      insurancePlan: json['insurancePlan'] as String,
      status: json['status'] as String,
      agent: json['agent'] as String?,
    );

Map<String, dynamic> _$InsuranceRequestsDataToJson(
        InsuranceRequestsData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'selfHelpGroup': instance.selfHelpGroup,
      'insuranceProvider': instance.insuranceProvider,
      'insurancePlan': instance.insurancePlan,
      'status': instance.status,
      'agent': instance.agent,
    };
