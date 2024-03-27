import 'package:ayad/src/models/settings.dart';

abstract class SettingsRepository {
  Future<Settings?> get();
  Future<void> update(Settings settings);
  
}