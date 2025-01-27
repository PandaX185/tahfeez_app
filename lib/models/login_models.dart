import 'package:json_annotation/json_annotation.dart';

part 'login_models.g.dart';

@JsonSerializable()
class LoginAsTeacherRequest {
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'password')
  final String password;

  LoginAsTeacherRequest({
    required this.phone,
    required this.password,
  });

  factory LoginAsTeacherRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginAsTeacherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAsTeacherRequestToJson(this);
}

@JsonSerializable()
class LoginAsStudentRequest {
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'password')
  final String password;

  LoginAsStudentRequest({
    required this.phone,
    required this.password,
  });

  factory LoginAsStudentRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginAsStudentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAsStudentRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'access_token')
  final String token;

  LoginResponse({
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
