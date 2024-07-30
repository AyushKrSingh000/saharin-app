// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_provider_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceProviderData _$InsuranceProviderDataFromJson(
        Map<String, dynamic> json) =>
    InsuranceProviderData(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InsuranceProviderDataToJson(
        InsuranceProviderData instance) =>
    <String, dynamic>{
      'location': instance.location,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      '__v': instance.v,
    };
