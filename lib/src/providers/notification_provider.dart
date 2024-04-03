import 'package:ayad/users/data/supabase_repository.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioPRovider = Provider((ref) => Dio(BaseOptions(
      headers: {
        'content-type': 'application/json',
        'Authorization':
            "key=AAAAyhBjGnQ:APA91bHZd88BrF4JfEuSz3P4FGUPHcE64uGLxsHxPSZlS41UTgKEXV4MDwqC8Rre-UOD7ylwS1Yj3v3Kbiw3iGMtOW2sQ9aDBWBJ8K7y3JxuKGI9r7pfStXF5jKDuLZsJo5HqfiR4kJB" // 'key=YOUR_SERVER_KEY'
      },
    )));
final notificationProviider = Provider((ref) => NotificationNotiferProvider(
    ref.read(dioPRovider), ref.read(supabaseUserRepositoryProvider)));

class NotificationNotiferProvider {
  NotificationNotiferProvider(this._dio, this._supabaseUserRepository);
  final SupabaseUserRepository _supabaseUserRepository;
  final Dio _dio;
  Future<bool> callOnFcmApiSendPushNotifications(
      List<String>? userToken, String title, String body) async {
    userToken ??= (await _supabaseUserRepository.getAll())
        ?.where((element) => element.token != null)
        .map((e) => e.token ?? "")
        .toList();
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids": userToken,
      "collapse_key": "type_a",
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
      }
    };

    // final headers = {
    //   'content-type': 'application/json',
    //   'Authorization':
    //       "AAAAyhBjGnQ:APA91bHZd88BrF4JfEuSz3P4FGUPHcE64uGLxsHxPSZlS41UTgKEXV4MDwqC8Rre-UOD7ylwS1Yj3v3Kbiw3iGMtOW2sQ9aDBWBJ8K7y3JxuKGI9r7pfStXF5jKDuLZsJo5HqfiR4kJB" // 'key=YOUR_SERVER_KEY'
    // };

    final response = await _dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      BotToast.showText(text: response.statusMessage ?? "");
      // on failure do sth
      return false;
    }
  }
}
