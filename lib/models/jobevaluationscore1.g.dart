// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobevaluationscore1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobEvaluationScore1 _$JobEvaluationScore1FromJson(Map<String, dynamic> json) =>
    JobEvaluationScore1(
      (json['evaluation_id'] as num?)?.toInt(),
      (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$JobEvaluationScore1ToJson(
        JobEvaluationScore1 instance) =>
    <String, dynamic>{
      'evaluation_id': instance.evaluation_id,
      'score': instance.score,
    };
