import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/evaluation.dart';

part 'evaluationscores.g.dart';

@JsonSerializable()
class Evaluationscores {
  int? evaluation_id;
  String? average_score;
  Evaluation? evaluation;
  Evaluationscores({this.evaluation_id, this.average_score, this.evaluation});

  factory Evaluationscores.fromJson(Map<String, dynamic> json) =>
      _$EvaluationscoresFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationscoresToJson(this);
}
