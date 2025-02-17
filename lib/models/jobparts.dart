import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/jobparttemplates.dart';
import 'package:paragon/models/part.dart';
part 'jobparts.g.dart';

@JsonSerializable()
class Jobparts {
  final int id;
  int? job_id;
  int? part_id;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;
  Part? part;
  List<JobPartTemplates>? job_part_templates;
  bool isOpen;

  Jobparts(
    this.id,
    this.job_id,
    this.part_id,
    this.create_by,
    this.created_at,
    this.update_by,
    this.updated_at,
    this.part,
    this.job_part_templates,
    {this.isOpen = false}
  );

  factory Jobparts.fromJson(Map<String, dynamic> json) => _$JobpartsFromJson(json);

  Map<String, dynamic> toJson() => _$JobpartsToJson(this);
}
