import 'package:ayad/src/data/settings_repository.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseSettingsRepositoryProvider =
    Provider((ref) => SupabaseSettingRepository(Supabase.instance.client));

class SupabaseSettingRepository implements SettingsRepository {
  final SupabaseClient _client;
  final String tableName = "settings";
  const SupabaseSettingRepository(this._client);
  @override
  Future<Settings?> get() async {
    final response =
        await _client.from(tableName).select().eq("fixedId", "fixedId");
    if (response.isEmpty) {
      return null;
    }
    return Settings.fromJson(response.first);
  }

  @override
  Future<void> update(Settings settings) async {
    final count = await _client.from(tableName).select().count();
    if (count.count == 0) {
      await _client
          .from(tableName)
          .insert(settings.toJson())
          .eq("fixedId", "fixedId");
    } else {
      await _client
          .from(tableName)
          .update(settings.toJson())
          .eq("fixedId", "fixedId");
    }
  }
}
