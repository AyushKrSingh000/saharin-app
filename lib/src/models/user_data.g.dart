// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      data: UserDataa.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'data': instance.data,
      'token': instance.token,
    };

UserDataa _$UserDataaFromJson(Map<String, dynamic> json) => UserDataa(
      user: UserLoggedData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataaToJson(UserDataa instance) => <String, dynamic>{
      'user': instance.user,
    };

UserLoggedData _$UserLoggedDataFromJson(Map<String, dynamic> json) =>
    UserLoggedData(
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['name'] as String?,
      id: json['_id'] as String,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserLoggedDataToJson(UserLoggedData instance) =>
    <String, dynamic>{
      'name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'type': instance.type,
      '_id': instance.id,
    };
