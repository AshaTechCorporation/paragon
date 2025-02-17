// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobusers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobUsers _$JobUsersFromJson(Map<String, dynamic> json) => JobUsers(
      (json['id'] as num).toInt(),
      (json['job_id'] as num?)?.toInt(),
      (json['user_id'] as num?)?.toInt(),
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobUsersToJson(JobUsers instance) => <String, dynamic>{
      'id': instance.id,
      'job_id': instance.job_id,
      'user_id': instance.user_id,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'user': instance.user,
    };
