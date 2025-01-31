import 'package:json_annotation/json_annotation.dart';

part 'teacher_models.g.dart';

@JsonSerializable()
class TeacherSelectionResponse {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;

  TeacherSelectionResponse({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory TeacherSelectionResponse.fromJson(Map<String, dynamic> json) =>
      _$TeacherSelectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherSelectionResponseToJson(this);
}
