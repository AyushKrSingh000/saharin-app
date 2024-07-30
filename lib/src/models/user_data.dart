import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final UserDataa data;
  final String token;

  UserData({
    required this.data,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class UserDataa {
  final UserLoggedData user;

  UserDataa({
    required this.user,
  });

  factory UserDataa.fromJson(Map<String, dynamic> json) {
    return _$UserDataaFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataaToJson(this);
}

@JsonSerializable()
class UserLoggedData {
  @JsonKey(name: 'name')
  final String? fullName;
  final String email;
  final String password;
  final String? type;
  @JsonKey(name: "_id")
  final String id;

  const UserLoggedData({
    required this.email,
    required this.password,
    this.fullName,
    required this.id,
    this.type,
  });
  factory UserLoggedData.fromJson(Map<String, dynamic> json) {
    return _$UserLoggedDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoggedDataToJson(this);
}
