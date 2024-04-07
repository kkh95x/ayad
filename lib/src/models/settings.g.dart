// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      fixedId: json['fixedId'] as String? ?? "fixedId",
      apkUrl: json['apkUrl'] as String,
      whatsAppPhone: json['whatsAppPhone'] as String,
      landtute: (json['landtute'] as num?)?.toDouble(),
      longtute: (json['longtute'] as num?)?.toDouble(),
      messageForCoustomer: json['messageForCoustomer'] as String,
      messageForVisotr: json['messageForVisotr'] as String,
      noteForPartsCustomer: json['noteForPartsCustomer'] as String?,
      noteFormPartsVistors: json['noteFormPartsVistors'] as String?,
      minVersion: json['minVersion'] as String? ?? "1.0.1",
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'fixedId': instance.fixedId,
      'apkUrl': instance.apkUrl,
      'whatsAppPhone': instance.whatsAppPhone,
      'landtute': instance.landtute,
      'longtute': instance.longtute,
      'messageForCoustomer': instance.messageForCoustomer,
      'messageForVisotr': instance.messageForVisotr,
      'noteForPartsCustomer': instance.noteForPartsCustomer,
      'noteFormPartsVistors': instance.noteFormPartsVistors,
      'minVersion': instance.minVersion,
    };
