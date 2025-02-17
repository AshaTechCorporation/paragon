// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      (json['id'] as num).toInt(),
      (json['work_type_id'] as num?)?.toInt(),
      json['name'] as String?,
      json['pdf_name'] as String?,
      (json['status'] as num?)?.toInt(),
      json['create_by'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['update_by'] as String?,
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'id': instance.id,
      'work_type_id': instance.work_type_id,
      'name': instance.name,
      'pdf_name': instance.pdf_name,
      'status': instance.status,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
