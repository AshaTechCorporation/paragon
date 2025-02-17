import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/customer.dart';
import 'package:paragon/models/evaluationscores.dart';
import 'package:paragon/models/permissions.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  int? permission_id;
  String? code;
  String? user_id;
  String? name;
  String? email;
  String? tel;
  String? register_date;
  String? image;
  String? status;
  String? type;
  int? customer_id;
  DateTime? created_at;
  DateTime? updated_at;
  Permissions? permission;
  Customer? customer;
  double? score_avg;
  String? remark;
  List<Evaluationscores>? evaluation_scores;

  User(
      this.id,
      this.permission_id,
      this.code,
      this.user_id,
      this.name,
      this.email,
      this.tel,
      this.register_date,
      this.customer_id,
      this.image,
      this.status,
      this.created_at,
      this.updated_at,
      this.permission,
      this.customer,
      this.score_avg,
      this.remark,
      this.evaluation_scores, this.type);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  void clear() {}
}
