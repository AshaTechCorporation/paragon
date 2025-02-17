import 'package:json_annotation/json_annotation.dart';
import 'package:paragon/models/notifylog.dart';

part 'notify.g.dart';

@JsonSerializable()
class Notify {
  int? id;
  int? notify_log_id;
  int? user_id;
  int? read;
  NotifyLog? notify_log;
  final DateTime? created_at;
  final DateTime? updated_at;

  Notify(this.id, this.notify_log, this.notify_log_id, this.read, this.user_id, this.created_at, this.updated_at);

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}
