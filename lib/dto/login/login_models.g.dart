// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAsTeacherRequest _$LoginAsTeacherRequestFromJson(
        Map<String, dynamic> json) =>
    LoginAsTeacherRequest(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginAsTeacherRequestToJson(
        LoginAsTeacherRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
    };

LoginAsStudentRequest _$LoginAsStudentRequestFromJson(
        Map<String, dynamic> json) =>
    LoginAsStudentRequest(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginAsStudentRequestToJson(
        LoginAsStudentRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['access_token'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.token,
    };
