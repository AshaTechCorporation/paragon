
import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/user.dart';

part 'jobusers.g.dart';

@JsonSerializable()
class JobUsers {
  final int id;
  int? job_id;
  int? user_id;
  DateTime? created_at;
  DateTime? updated_at;
  User? user;

  JobUsers(
    this.id,
    this.job_id,
    this.user_id,
    this.created_at,
    this.updated_at,
    this.user
  );

  factory JobUsers.fromJson(Map<String, dynamic> json) => _$JobUsersFromJson(json);

  Map<String, dynamic> toJson() => _$JobUsersToJson(this);
}
