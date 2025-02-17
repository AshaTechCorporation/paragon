// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => Evaluation(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      name_en: json['name_en'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'name_en': instance.name_en,
      'status': instance.status,
    };
