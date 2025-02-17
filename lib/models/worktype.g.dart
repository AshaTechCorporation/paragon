// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worktype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worktype _$WorktypeFromJson(Map<String, dynamic> json) => Worktype(
      (json['id'] as num).toInt(),
      json['code'] as String?,
      json['name'] as String?,
      json['title_doc'] as String?,
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

Map<String, dynamic> _$WorktypeToJson(Worktype instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'title_doc': instance.title_doc,
      'status': instance.status,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
