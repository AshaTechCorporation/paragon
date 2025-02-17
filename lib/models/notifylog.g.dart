// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifylog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyLog _$NotifyLogFromJson(Map<String, dynamic> json) => NotifyLog(
      (json['id'] as num).toInt(),
      json['detail'] as String?,
      json['image'] as String?,
      (json['status'] as num?)?.toInt(),
      json['target_id'] as String?,
      json['title'] as String?,
      json['type'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$NotifyLogToJson(NotifyLog instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
      'url': instance.url,
      'image': instance.image,
      'target_id': instance.target_id,
      'type': instance.type,
      'status': instance.status,
    };
