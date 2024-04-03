import 'package:ayad/src/data/supabase_app_notification_repoository.dart';
import 'package:ayad/src/models/app_notification.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appNotificationHelperProvider = Provider((ref) => AppNotificationNotifer(
    ref.read(supabaseUserRepositoryProvider),
    (ref.read(authNotifierProvider).value?.currentUser?.id ?? ""),
    ref.read(supabaseAppNotificationProvider)));

class AppNotificationNotifer {
  final SupabaseUserRepository _repository;
  final SupabaseAppNotificationRepository _appNotificationRepository;
  final String _senderId;
  AppNotificationNotifer(
      this._repository, this._senderId, this._appNotificationRepository);


  Future sendToAllUsersNotification(String title, String body,
      {List<AppUser>? users,String?productId}) async {
    List<String> ids;
    if (users != null) {
      ids = users.map((e) => e.id ?? "").toList();
    } else {
      ids = await _repository.getAllIds();
    }
    final notifications = ids
        .map((e) => AppNotification(
            title: title,
            body: body,
            productId: productId,
            userId: e,
            createAt: DateTime.now(),
            senderId: _senderId))
        .toList();

    await _appNotificationRepository.createMultipleRows(notifications);
  }

  
}
