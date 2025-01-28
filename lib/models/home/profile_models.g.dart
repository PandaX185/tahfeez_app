// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      birthDate: json['birthDate'] as String?,
      level: (json['level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'birthDate': instance.birthDate,
      'level': instance.level,
    };
