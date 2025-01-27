import 'package:json_annotation/json_annotation.dart';

part 'teacher_models.g.dart';

@JsonSerializable()
class TeacherResponse {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;

  TeacherResponse({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory TeacherResponse.fromJson(Map<String, dynamic> json) =>
      _$TeacherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherResponseToJson(this);
}
