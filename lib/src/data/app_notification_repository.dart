import 'package:ayad/src/models/app_notification.dart';

abstract class AppNotificationRepository{
  Future<void> create(AppNotification appNotification);
  Future<void> update(AppNotification appNotification);
  Future<List<AppNotification>> getMyNotification(String userId, int limit);
  Future<int> getMyNotificationCount(String userId,);
  Future<void> createMultipleRows(List<AppNotification> appNotifications);
}