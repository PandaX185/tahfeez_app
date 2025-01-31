// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      name: json['name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      level: json['level'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'level': instance.level,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      level: json['level'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'level': instance.level,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
    };
