import 'package:json_annotation/json_annotation.dart';

part 'template.g.dart';

@JsonSerializable()
class Template {
  final int id;
  int? work_type_id;
  String? name;
  String? pdf_name;
  int? status;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;

  Template(
    this.id,
    this.work_type_id,
    this.name,
    this.pdf_name,
    this.status,
    this.create_by,
    this.created_at,
    this.update_by,
    this.updated_at
  );

  factory Template.fromJson(Map<String, dynamic> json) => _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}
