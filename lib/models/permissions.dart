import 'package:json_annotation/json_annotation.dart';

part 'permissions.g.dart';

@JsonSerializable()
class Permissions {
  final int id;
  String? name;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;

  Permissions(
    this.id,
    this.name,
    this.create_by,
    this.update_by,
    this.created_at,
    this.updated_at
  );

  factory Permissions.fromJson(Map<String, dynamic> json) => _$PermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionsToJson(this);

}
