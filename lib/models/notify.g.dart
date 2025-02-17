// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) => Notify(
      (json['id'] as num?)?.toInt(),
      json['notify_log'] == null
          ? null
          : NotifyLog.fromJson(json['notify_log'] as Map<String, dynamic>),
      (json['notify_log_id'] as num?)?.toInt(),
      (json['read'] as num?)?.toInt(),
      (json['user_id'] as num?)?.toInt(),
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$NotifyToJson(Notify instance) => <String, dynamic>{
      'id': instance.id,
      'notify_log_id': instance.notify_log_id,
      'user_id': instance.user_id,
      'read': instance.read,
      'notify_log': instance.notify_log,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
