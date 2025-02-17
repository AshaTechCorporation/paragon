import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final int id;
  int? permission_id;
  String? code;
  String? name;
  String? tax_id;
  String? address;
  String? tel;
  String? email;
  String? contact_name;
  String? contact_tel;
  String? contact_position;
  String? ma_start_date;
  String? ma_end_date;
  int? status;
  DateTime? created_at;
  DateTime? updated_at;

  Customer(
    this.id,
    this.address,
    this.code,
    this.contact_name,
    this.contact_position,
    this.contact_tel,
    this.created_at,
    this.email,
    this.ma_end_date,
    this.ma_start_date,
    this.name,
    this.permission_id,
    this.status,
    this.tax_id,
    this.tel,
    this.updated_at
  );

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}
