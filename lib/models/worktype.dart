import 'package:json_annotation/json_annotation.dart';

part 'worktype.g.dart';

@JsonSerializable()
class Worktype {
  final int id;
  String? code;
  String? name;
  String? title_doc;
  int? status;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;

  Worktype(
    this.id,
    this.code,
    this.name,
    this.title_doc,
    this.status,
    this.create_by,
    this.created_at,
    this.update_by,
    this.updated_at
  );

  factory Worktype.fromJson(Map<String, dynamic> json) => _$WorktypeFromJson(json);

  Map<String, dynamic> toJson() => _$WorktypeToJson(this);
}
