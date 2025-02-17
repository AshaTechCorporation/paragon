// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluationscores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluationscores _$EvaluationscoresFromJson(Map<String, dynamic> json) =>
    Evaluationscores(
      evaluation_id: (json['evaluation_id'] as num?)?.toInt(),
      average_score: json['average_score'] as String?,
      evaluation: json['evaluation'] == null
          ? null
          : Evaluation.fromJson(json['evaluation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EvaluationscoresToJson(Evaluationscores instance) =>
    <String, dynamic>{
      'evaluation_id': instance.evaluation_id,
      'average_score': instance.average_score,
      'evaluation': instance.evaluation,
    };
