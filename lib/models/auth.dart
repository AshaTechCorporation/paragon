import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/user.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String code;
  bool status;
  String message;
  User? data;
  String token;

  Auth(
    this.code,
    this.status,
    this.message,
    this.data,
    this.token
  );

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);

}
