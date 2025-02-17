import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable()
class Vendor {
  final int id;
  String? code;
  String? name;
  String? tax_id;
  String? address;
  String? email;
  String? email2;
  String? tel;
  String? tel_remark;
  String? tel2;
  String? line_id;
  String? note_contact;
  String? contact_name;
  String? contact_tel;
  String? image;
  int? status;
  String? create_by;
  String? update_by;
  DateTime? created_at;
  DateTime? updated_at;

  Vendor(
    this.id,
    this.address,
    this.code,
    this.contact_name,
    this.contact_tel,
    this.create_by,
    this.created_at,
    this.email,
    this.email2,
    this.image,
    this.line_id,
    this.name,
    this.note_contact,
    this.status,
    this.tax_id,
    this.tel,
    this.tel2,
    this.tel_remark,
    this.update_by,
    this.updated_at
  );

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);

}
