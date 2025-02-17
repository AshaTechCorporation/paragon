// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num).toInt(),
      (json['permission_id'] as num?)?.toInt(),
      json['code'] as String?,
      json['user_id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['tel'] as String?,
      json['register_date'] as String?,
      (json['customer_id'] as num?)?.toInt(),
      json['image'] as String?,
      json['status'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['permission'] == null
          ? null
          : Permissions.fromJson(json['permission'] as Map<String, dynamic>),
      json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      (json['score_avg'] as num?)?.toDouble(),
      json['remark'] as String?,
      (json['evaluation_scores'] as List<dynamic>?)
          ?.map((e) => Evaluationscores.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['type'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'permission_id': instance.permission_id,
      'code': instance.code,
      'user_id': instance.user_id,
      'name': instance.name,
      'email': instance.email,
      'tel': instance.tel,
      'register_date': instance.register_date,
      'image': instance.image,
      'status': instance.status,
      'type': instance.type,
      'customer_id': instance.customer_id,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'permission': instance.permission,
      'customer': instance.customer,
      'score_avg': instance.score_avg,
      'remark': instance.remark,
      'evaluation_scores': instance.evaluation_scores,
    };
