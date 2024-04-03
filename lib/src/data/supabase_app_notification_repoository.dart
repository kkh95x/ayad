import 'package:ayad/src/data/app_notification_repository.dart';
import 'package:ayad/src/models/app_notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabaseAppNotificationProvider=Provider((ref) => SupabaseAppNotificationRepository(Supabase.instance.client));
class SupabaseAppNotificationRepository implements AppNotificationRepository {
  final SupabaseClient _client;
  const SupabaseAppNotificationRepository(this._client);
  final String tableName = "Notifications";
  @override
  Future<void> create(AppNotification appNotification) async {
    final data = appNotification.toJson();
    data.remove("id");
    await _client.from(tableName).insert(data);
  }

  @override
  Future<List<AppNotification>> getMyNotification(String userId,int limit) async {
    final query =  _client.from(tableName).select().eq("userId", userId).limit(limit).order("createAt",ascending: false);
    final data=await query;
    return data.map((e) => AppNotification.fromJson(e)).toList();
  }

  @override
  Future<void> update(AppNotification appNotification) async{
    await _client.from(tableName).update(appNotification.toJson()).eq("id", appNotification.id??"");
  }
  
  @override
  Future<void> createMultipleRows(List<AppNotification> appNotifications)async {
   final data=appNotifications.map((e)  {
    final white=e.toJson();
    white.remove("id");
    return white;
   }).toList();
   await _client.from(tableName).insert(data);
  }
  
  @override
  Future<int> getMyNotificationCount(String userId) async{
     final query =await  _client.from(tableName).select().eq("userId", userId).count();
     return  query.count;
  }
}
