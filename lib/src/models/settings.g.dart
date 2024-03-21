// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      id: json['id'] as String?,
      fixedId: json['fixedId'] as String? ?? "fixedId",
      marketInfo: json['marketInfo'] as String,
      whatsAppPhone: json['whatsAppPhone'] as String,
      minVersion: json['minVersion'] as String? ?? "1.0.1",
      appUrl: json['appUrl'] as String?,
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fixedId': instance.fixedId,
      'marketInfo': instance.marketInfo,
      'whatsAppPhone': instance.whatsAppPhone,
      'minVersion': instance.minVersion,
      'appUrl': instance.appUrl,
    };
