import 'package:json_annotation/json_annotation.dart';

part 'part.g.dart';

@JsonSerializable()
class Part {
  final int id;
  int? work_type_id;
  String? part_no;
  String? name;
  String? name_en;
  String? image;
  int? status;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;

  Part(
    this.id,
    this.work_type_id,
    this.part_no,
    this.name,
    this.name_en,
    this.image,
    this.status,
    this.create_by,
    this.created_at,
    this.update_by,
    this.updated_at
  );

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  Map<String, dynamic> toJson() => _$PartToJson(this);
}
