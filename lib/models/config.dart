import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  int? id;
  String? condition;
  String? tel;
  String? email;
  String? facebook;
  String? line;
  int? status;
  Config(
    this.id,
    this.condition,
    this.tel,
    this.email,
    this.facebook,
    this.line,
    this.status,
  );

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
