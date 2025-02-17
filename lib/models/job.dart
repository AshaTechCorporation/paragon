import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/customer.dart';
import 'package:paragon/models/detail.dart';
import 'package:paragon/models/jobevaluationscore.dart';
import 'package:paragon/models/jobparts.dart';
import 'package:paragon/models/jobparttemplates.dart';
import 'package:paragon/models/jobusers.dart';
import 'package:paragon/models/vendor.dart';
import 'package:paragon/models/worktype.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  final int id;
  String? doc_name;
  String? doc_exp_date;
  int? work_type_id;
  int? vendor_id;
  int? customer_id;
  int? format_id;
  String? code;
  String? po_no;
  String? date;
  int? seq;
  String? pm_date;
  String? item;
  String? name;
  String? image;
  String? project;
  String? address;
  String? location;
  String? status;
  String? assign_by;
  DateTime? assign_at;
  String? finish_by;
  DateTime? finish_at;
  String? check_by;
  DateTime? check_at;
  String? cancel_by;
  DateTime? cancel_at;
  String? remark;
  double? score;
  String? score_remark;
  String? score_by;
  DateTime? created_at;
  DateTime? updated_at;
  String? qr_code;
  String? user_assign;
  int? No;
  Detail? detail;
  bool? exp_status;
  Worktype? work_type;
  List<Jobparts>? job_parts;
  List<JobUsers>? job_users;
  List<JobPartTemplates>? job_part_templates;
  Vendor? vendor;
  Customer? customer;
  List<JobEvaluationScore>? job_evaluation_scores;

  Job(
    this.id,
    this.doc_name,
    this.doc_exp_date,
    this.work_type_id,
    this.vendor_id,
    this.customer_id,
    this.format_id,
    this.code,
    this.po_no,
    this.date,
    this.seq,
    this.pm_date,
    this.item,
    this.name,
    this.image,
    this.project,
    this.address,
    this.location,
    this.status,
    this.assign_at,
    this.assign_by,
    this.finish_by,
    this.finish_at,
    this.check_by,
    this.check_at,
    this.cancel_by,
    this.cancel_at,
    this.remark,
    this.score,
    this.score_remark,
    this.score_by,
    this.created_at,
    this.updated_at,
    this.qr_code,
    this.No,
    this.detail,
    this.work_type,
    this.exp_status,
    this.job_parts,
    this.vendor,
    this.job_part_templates,
    this.job_evaluation_scores,
    this.customer,
    this.job_users,
    this.user_assign
  );

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
}
