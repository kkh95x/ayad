import 'package:ayad/src/data/supbase_settings_repository.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getSettingFuture = FutureProvider.autoDispose<Settings?>((ref) async {
  try {
    final setting = await ref.read(supabaseSettingsRepositoryProvider).get();
    if (setting != null) {
      ref.read(sharedPrefranceServiceProvider).saveSetting(setting);
    }
    return setting;
  } catch (e) {
  return await  ref.read(sharedPrefranceServiceProvider).getSetting();
  }
});
final getSettingAdminFuture = FutureProvider.autoDispose<Settings?>((ref) async {
  try {
    final setting = await ref.read(supabaseSettingsRepositoryProvider).get();
    if (setting != null) {
      ref.read(sharedPrefranceServiceProvider).saveSetting(setting);
    }
    return setting;
  } catch (e) {
  throw Exception("لم نتمكن من الوصول للسيرفر");
  }
});