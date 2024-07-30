// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_plan_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsurancePlanData _$InsurancePlanDataFromJson(Map<String, dynamic> json) =>
    InsurancePlanData(
      id: json['_id'] as String,
      name: json['name'] as String,
      premium: (json['premium'] as num).toInt(),
      coverage: (json['coverage'] as num).toInt(),
      insuranceProvider: json['insuranceProvider'] as String,
    );

Map<String, dynamic> _$InsurancePlanDataToJson(InsurancePlanData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'premium': instance.premium,
      'coverage': instance.coverage,
      'insuranceProvider': instance.insuranceProvider,
    };
