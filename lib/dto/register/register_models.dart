import 'package:json_annotation/json_annotation.dart';

part 'register_models.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'level')
  final int level;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'birthDate')
  final String birthDate;
  @JsonKey(name: 'teacherId')
  final String teacherId;

  RegisterRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.level,
    required this.gender,
    required this.birthDate,
    required this.teacherId,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'level')
  final String level;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'birthDate')
  final String birthDate;

  RegisterResponse({
    required this.id,
    required this.name,
    required this.phone,
    required this.level,
    required this.gender,
    required this.birthDate,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
