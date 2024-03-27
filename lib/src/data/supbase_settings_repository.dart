import 'package:ayad/src/data/settings_repository.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSettingRepository implements SettingsRepository {
  final SupabaseClient _client;
  final String tableName = "settings";
  const SupabaseSettingRepository(this._client);
  @override
  Future<Settings?> get()async {
  final response=await  _client.from(tableName).select().eq("fixedId", "fixedId");
  if(response.isEmpty){
    return null;
  }
  return Settings.fromJson(response.first);

  }

  @override
  Future<void> update(Settings settings)async {
    await _client.from(tableName).update(settings.toJson()).eq("fixedId", "fixedId");
  }
}
