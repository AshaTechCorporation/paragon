// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      (json['id'] as num?)?.toInt(),
      json['condition'] as String?,
      json['tel'] as String?,
      json['email'] as String?,
      json['facebook'] as String?,
      json['line'] as String?,
      (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'id': instance.id,
      'condition': instance.condition,
      'tel': instance.tel,
      'email': instance.email,
      'facebook': instance.facebook,
      'line': instance.line,
      'status': instance.status,
    };
