// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      (json['id'] as num).toInt(),
      json['doc_name'] as String?,
      json['doc_exp_date'] as String?,
      (json['work_type_id'] as num?)?.toInt(),
      (json['vendor_id'] as num?)?.toInt(),
      (json['customer_id'] as num?)?.toInt(),
      (json['format_id'] as num?)?.toInt(),
      json['code'] as String?,
      json['po_no'] as String?,
      json['date'] as String?,
      (json['seq'] as num?)?.toInt(),
      json['pm_date'] as String?,
      json['item'] as String?,
      json['name'] as String?,
      json['image'] as String?,
      json['project'] as String?,
      json['address'] as String?,
      json['location'] as String?,
      json['status'] as String?,
      json['assign_at'] == null
          ? null
          : DateTime.parse(json['assign_at'] as String),
      json['assign_by'] as String?,
      json['finish_by'] as String?,
      json['finish_at'] == null
          ? null
          : DateTime.parse(json['finish_at'] as String),
      json['check_by'] as String?,
      json['check_at'] == null
          ? null
          : DateTime.parse(json['check_at'] as String),
      json['cancel_by'] as String?,
      json['cancel_at'] == null
          ? null
          : DateTime.parse(json['cancel_at'] as String),
      json['remark'] as String?,
      (json['score'] as num?)?.toDouble(),
      json['score_remark'] as String?,
      json['score_by'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['qr_code'] as String?,
      (json['No'] as num?)?.toInt(),
      json['detail'] == null
          ? null
          : Detail.fromJson(json['detail'] as Map<String, dynamic>),
      json['work_type'] == null
          ? null
          : Worktype.fromJson(json['work_type'] as Map<String, dynamic>),
      json['exp_status'] as bool?,
      (json['job_parts'] as List<dynamic>?)
          ?.map((e) => Jobparts.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['vendor'] == null
          ? null
          : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
      (json['job_part_templates'] as List<dynamic>?)
          ?.map((e) => JobPartTemplates.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['job_evaluation_scores'] as List<dynamic>?)
          ?.map((e) => JobEvaluationScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      (json['job_users'] as List<dynamic>?)
          ?.map((e) => JobUsers.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['user_assign'] as String?,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'doc_name': instance.doc_name,
      'doc_exp_date': instance.doc_exp_date,
      'work_type_id': instance.work_type_id,
      'vendor_id': instance.vendor_id,
      'customer_id': instance.customer_id,
      'format_id': instance.format_id,
      'code': instance.code,
      'po_no': instance.po_no,
      'date': instance.date,
      'seq': instance.seq,
      'pm_date': instance.pm_date,
      'item': instance.item,
      'name': instance.name,
      'image': instance.image,
      'project': instance.project,
      'address': instance.address,
      'location': instance.location,
      'status': instance.status,
      'assign_by': instance.assign_by,
      'assign_at': instance.assign_at?.toIso8601String(),
      'finish_by': instance.finish_by,
      'finish_at': instance.finish_at?.toIso8601String(),
      'check_by': instance.check_by,
      'check_at': instance.check_at?.toIso8601String(),
      'cancel_by': instance.cancel_by,
      'cancel_at': instance.cancel_at?.toIso8601String(),
      'remark': instance.remark,
      'score': instance.score,
      'score_remark': instance.score_remark,
      'score_by': instance.score_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'qr_code': instance.qr_code,
      'user_assign': instance.user_assign,
      'No': instance.No,
      'detail': instance.detail,
      'exp_status': instance.exp_status,
      'work_type': instance.work_type,
      'job_parts': instance.job_parts,
      'job_users': instance.job_users,
      'job_part_templates': instance.job_part_templates,
      'vendor': instance.vendor,
      'customer': instance.customer,
      'job_evaluation_scores': instance.job_evaluation_scores,
    };
