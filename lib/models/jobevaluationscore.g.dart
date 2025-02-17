// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobevaluationscore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobEvaluationScore _$JobEvaluationScoreFromJson(Map<String, dynamic> json) =>
    JobEvaluationScore(
      (json['evaluation_id'] as num?)?.toInt(),
      (json['score'] as num?)?.toDouble(),
      json['evaluation'] == null
          ? null
          : Evaluation.fromJson(json['evaluation'] as Map<String, dynamic>),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JobEvaluationScoreToJson(JobEvaluationScore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'evaluation_id': instance.evaluation_id,
      'score': instance.score,
      'evaluation': instance.evaluation,
    };
