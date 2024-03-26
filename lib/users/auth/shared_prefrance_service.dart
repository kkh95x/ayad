import 'dart:convert';

import 'package:ayad/users/domain/user.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final sharedPrefranceServiceProvider=Provider((ref) => SharedPrefranceServce());
class SharedPrefranceServce {
  static late EncryptedSharedPreferences _sharedPreferences;
  final _userKey = "fdskhskjdfbhskjf";
  static Future<void> initial() async {
    String myKey = "arim@Elkhatib111";

    await EncryptedSharedPreferences.initialize(myKey);
    _sharedPreferences = EncryptedSharedPreferences.getInstance();
  }

  Future<void> saveUser(AppUser user) async {
    final data = jsonEncode(user.toJson());
    await _sharedPreferences.setString(_userKey, data);
    return;
  }
  Future<void> deleteUserLocaly()async{
   await _sharedPreferences.remove(_userKey);
  }
  Future<AppUser?> getUser() async {
    final datalocal = _sharedPreferences.get(_userKey);
    if (datalocal == null) {
      return null;
    }
    try {
      final data = jsonDecode(datalocal) as Map<String, dynamic>;
      final user = AppUser.fromJson(data);
      return user;
    } catch (e) {
      return null;
    }
  }
}
