import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_notification.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'app_notification.g.dart';



enum SubType { groups, products }

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    String? id,
    required String title,
    required String body,
    required String userId,
    required DateTime createAt,
    required String senderId,
    String? productId,
    @Default(false) bool isSeen,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, Object?> json) => _$AppNotificationFromJson(json);
}
