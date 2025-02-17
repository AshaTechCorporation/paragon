// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      (json['id'] as num).toInt(),
      json['address'] as String?,
      json['code'] as String?,
      json['contact_name'] as String?,
      json['contact_position'] as String?,
      json['contact_tel'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['email'] as String?,
      json['ma_end_date'] as String?,
      json['ma_start_date'] as String?,
      json['name'] as String?,
      (json['permission_id'] as num?)?.toInt(),
      (json['status'] as num?)?.toInt(),
      json['tax_id'] as String?,
      json['tel'] as String?,
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'permission_id': instance.permission_id,
      'code': instance.code,
      'name': instance.name,
      'tax_id': instance.tax_id,
      'address': instance.address,
      'tel': instance.tel,
      'email': instance.email,
      'contact_name': instance.contact_name,
      'contact_tel': instance.contact_tel,
      'contact_position': instance.contact_position,
      'ma_start_date': instance.ma_start_date,
      'ma_end_date': instance.ma_end_date,
      'status': instance.status,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
