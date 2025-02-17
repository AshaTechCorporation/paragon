
import 'package:json_annotation/json_annotation.dart';

part 'jobevaluationscore1.g.dart';

@JsonSerializable()
class JobEvaluationScore1 {
  int? evaluation_id;
  double? score;

  JobEvaluationScore1(
    this.evaluation_id,
    this.score,
  );

  factory JobEvaluationScore1.fromJson(Map<String, dynamic> json) => _$JobEvaluationScore1FromJson(json);

  Map<String, dynamic> toJson() => _$JobEvaluationScore1ToJson(this);
}
