import 'dart:convert';

import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPrefranceServiceProvider =
    Provider((ref) => SharedPrefranceServce());

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

  Future<void> deleteUserLocaly() async {
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

  final String _groupKey = "arim@fdskhskjdfbhskjf";

  Future<void> saveGroups(List<Group> groups) async {
    await _sharedPreferences.remove(_groupKey);
    final data = jsonEncode(groups.map((e) => e.toJson()).toList());
    await _sharedPreferences.setString(_groupKey, data);
  }

  Future<List<Group>?> getGroups() async {
    final data = _sharedPreferences.get(_groupKey);
    if (data == null) {
      return null;
    }
    final mapsData = jsonDecode(data) as List<dynamic>;
    return mapsData
        .map((e) => Group.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveSubGroups(List<Group> groups, String parentId) async {
    await _sharedPreferences.remove(parentId);
    final data = jsonEncode(groups.map((e) => e.toJson()).toList());
    await _sharedPreferences.setString(parentId, data);
  }

  Future<List<Group>?> getSupGroups(String parentId) async {
    final data = _sharedPreferences.get(parentId);
    if (data == null) {
      return null;
    }
    final mapsData = jsonDecode(data) as List<dynamic>;
    return mapsData
        .map((e) => Group.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveProduct(List<Product> products, String parentId) async {
    await _sharedPreferences.remove(parentId);
    final data = jsonEncode(products.map((e) => e.toJson()).toList());
    await _sharedPreferences.setString(parentId, data);
  }

  Future<List<Product>?> getProduct(String parentId) async {
    final data = _sharedPreferences.get(parentId);
    if (data == null) {
      return null;
    }
    final mapsData = jsonDecode(data) as List<dynamic>;
    return mapsData
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
