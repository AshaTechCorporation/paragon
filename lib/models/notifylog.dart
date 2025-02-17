import 'package:json_annotation/json_annotation.dart';

part 'notifylog.g.dart';

@JsonSerializable()
class NotifyLog {
  final int id;
  String? title;
  String? detail;
  String? url;
  String? image;
  String? target_id;
  String? type;
  int? status;

  NotifyLog(this.id, this.detail, this.image, this.status, this.target_id, this.title, this.type, this.url);

  factory NotifyLog.fromJson(Map<String, dynamic> json) => _$NotifyLogFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyLogToJson(this);
}
