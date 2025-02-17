// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Part _$PartFromJson(Map<String, dynamic> json) => Part(
      (json['id'] as num).toInt(),
      (json['work_type_id'] as num?)?.toInt(),
      json['part_no'] as String?,
      json['name'] as String?,
      json['name_en'] as String?,
      json['image'] as String?,
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

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
      'id': instance.id,
      'work_type_id': instance.work_type_id,
      'part_no': instance.part_no,
      'name': instance.name,
      'name_en': instance.name_en,
      'image': instance.image,
      'status': instance.status,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
