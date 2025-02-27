import 'package:ayad/src/data/supbase_settings_repository.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getSettingFuture = FutureProvider.autoDispose<Settings?>((ref) async {
  try {
    final setting = await ref.read(supabaseSettingsRepositoryProvider).get();
    if (setting != null) {
      ref.read(sharedPrefranceServiceProvider).saveSetting(setting);
    }
    return setting;
  } catch (e) {
    final setting = await ref.read(sharedPrefranceServiceProvider).getSetting();
    if (setting != null) {
      return setting;
    } else {
      BotToast.showText(text: "لم نتمكن من الوصول إلى السيرفر");
      throw Exception(e);
    }
  }
});
final getSettingAdminFuture =
    FutureProvider.autoDispose<Settings?>((ref) async {
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
