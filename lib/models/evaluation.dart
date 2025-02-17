import 'package:json_annotation/json_annotation.dart';

part 'evaluation.g.dart';

@JsonSerializable()
class Evaluation {
  int? id;
  String? code;
  String? name;
  String? name_en;
  int? status;
  Evaluation({
    this.id,
    this.code,
    this.name,
    this.name_en,
    this.status,
  });
  factory Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}
