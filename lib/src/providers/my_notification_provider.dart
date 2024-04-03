import 'dart:async';

import 'package:ayad/src/data/supabase_app_notification_repoository.dart';
import 'package:ayad/src/models/app_notification.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final limitNotificationScrolleProvider = StateProvider((ref) => 1);

final notificationPaginationProvider = AsyncNotifierProvider.autoDispose<
    AlertStudentsNotifer, (List<AppNotification>, int)>(() {
  return AlertStudentsNotifer();
});

class AlertStudentsNotifer
    extends AutoDisposeAsyncNotifier<(List<AppNotification>, int)> {
  int? limitCount;
  AlertStudentsNotifer();
  RealtimeChannel? realtimeChannel;
  @override
  FutureOr<(List<AppNotification>, int)> build() async {
    final appNotificationRepo = ref.watch(supabaseAppNotificationProvider);
    final userId = ref.watch(authNotifierProvider).value?.currentUser?.id ?? "";
    var limit = ref.watch(limitNotificationScrolleProvider);
    limitCount = await appNotificationRepo.getMyNotificationCount(userId);
    realtimeChannel = Supabase.instance.client
        .channel('public:Notifications')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'Notifications',
            callback: (payload) async {
              limitCount =
                  await appNotificationRepo.getMyNotificationCount(userId);

              state = AsyncData((
                await appNotificationRepo.getMyNotification(userId, limit * 10),
                limitCount ?? 0
              ));
            })
        .subscribe();
    return (
      await appNotificationRepo.getMyNotification(userId, limit * 10),
      limitCount ?? 0
    );
  }
}
