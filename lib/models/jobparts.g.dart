// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobparts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobparts _$JobpartsFromJson(Map<String, dynamic> json) => Jobparts(
      (json['id'] as num).toInt(),
      (json['job_id'] as num?)?.toInt(),
      (json['part_id'] as num?)?.toInt(),
      json['create_by'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['update_by'] as String?,
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['part'] == null
          ? null
          : Part.fromJson(json['part'] as Map<String, dynamic>),
      (json['job_part_templates'] as List<dynamic>?)
          ?.map((e) => JobPartTemplates.fromJson(e as Map<String, dynamic>))
          .toList(),
      isOpen: json['isOpen'] as bool? ?? false,
    );

Map<String, dynamic> _$JobpartsToJson(Jobparts instance) => <String, dynamic>{
      'id': instance.id,
      'job_id': instance.job_id,
      'part_id': instance.part_id,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'part': instance.part,
      'job_part_templates': instance.job_part_templates,
      'isOpen': instance.isOpen,
    };
