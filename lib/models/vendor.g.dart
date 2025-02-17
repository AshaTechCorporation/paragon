// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      (json['id'] as num).toInt(),
      json['address'] as String?,
      json['code'] as String?,
      json['contact_name'] as String?,
      json['contact_tel'] as String?,
      json['create_by'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['email'] as String?,
      json['email2'] as String?,
      json['image'] as String?,
      json['line_id'] as String?,
      json['name'] as String?,
      json['note_contact'] as String?,
      (json['status'] as num?)?.toInt(),
      json['tax_id'] as String?,
      json['tel'] as String?,
      json['tel2'] as String?,
      json['tel_remark'] as String?,
      json['update_by'] as String?,
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'tax_id': instance.tax_id,
      'address': instance.address,
      'email': instance.email,
      'email2': instance.email2,
      'tel': instance.tel,
      'tel_remark': instance.tel_remark,
      'tel2': instance.tel2,
      'line_id': instance.line_id,
      'note_contact': instance.note_contact,
      'contact_name': instance.contact_name,
      'contact_tel': instance.contact_tel,
      'image': instance.image,
      'status': instance.status,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
