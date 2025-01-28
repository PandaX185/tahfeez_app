import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'birthDate')
  final String? birthDate;
  @JsonKey(name: 'level')
  final int? level;

  const ProfileResponse({
    required this.id,
    required this.name,
    required this.phone,
    this.birthDate,
    this.level,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
