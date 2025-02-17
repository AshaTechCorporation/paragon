import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/jobparts.dart';
import 'package:paragon/models/worktype.dart';

part 'detail.g.dart';

@JsonSerializable()
class Detail {
  Worktype? work_type;
  String? vendor;
  String? customer;
  List<Jobparts>? job_parts;

  Detail(
    this.work_type,
    this.vendor,
    this.customer,
    this.job_parts
  );

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
