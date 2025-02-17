
import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/evaluation.dart';

part 'jobevaluationscore.g.dart';

@JsonSerializable()
class JobEvaluationScore {
  int? id;
  int? evaluation_id;
  double? score;
  Evaluation? evaluation;

  JobEvaluationScore(
    this.evaluation_id,
    this.score,
    this.evaluation,
    this.id
  );

  factory JobEvaluationScore.fromJson(Map<String, dynamic> json) => _$JobEvaluationScoreFromJson(json);

  Map<String, dynamic> toJson() => _$JobEvaluationScoreToJson(this);
}
