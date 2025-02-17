// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      json['code'] as String,
      json['status'] as bool,
      json['message'] as String,
      json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
