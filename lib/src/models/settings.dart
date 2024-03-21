import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'settings.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    String? id,
    @Default("fixedId")  String fixedId,
    required String marketInfo,
    required String whatsAppPhone,
    @Default("1.0.1") String minVersion,
    String? appUrl,
    

  }) = _Settings;

  factory Settings.fromJson(Map<String, Object?> json)
      => _$SettingsFromJson(json);
}