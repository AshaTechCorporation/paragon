// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      json['work_type'] == null
          ? null
          : Worktype.fromJson(json['work_type'] as Map<String, dynamic>),
      json['vendor'] as String?,
      json['customer'] as String?,
      (json['job_parts'] as List<dynamic>?)
          ?.map((e) => Jobparts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'work_type': instance.work_type,
      'vendor': instance.vendor,
      'customer': instance.customer,
      'job_parts': instance.job_parts,
    };
