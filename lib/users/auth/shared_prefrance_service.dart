import 'dart:convert';

import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:ayad/src/models/slides.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPrefranceServiceProvider =
    Provider((ref) => SharedPrefranceServce());

class SharedPrefranceServce {
  static late SharedPreferences _sharedPreferences;
  final _userKey = "fdskhskjdfbhskjf";
  static Future<void> initial() async {
    // String myKey = "arim@Elkhatib111";

    await SharedPreferences.getInstance();
    _sharedPreferences =await SharedPreferences.getInstance();
  }
  Future<void> clearAll() async {
   await _sharedPreferences.clear();
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
      final data = jsonDecode(datalocal.toString()) as Map<String, dynamic>;
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
    final mapsData = jsonDecode(data.toString()) as List<dynamic>;
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
    final mapsData = jsonDecode(data.toString()) as List<dynamic>;
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
    final mapsData = jsonDecode(data.toString()) as List<dynamic>;
    return mapsData
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
    Future<void> saveSetting(Settings settings) async {
    await _sharedPreferences.remove("settings");
    final data = jsonEncode(settings.toJson());
    await _sharedPreferences.setString("settings", data);
  }

  Future<Settings?> getSetting() async {
    final data = _sharedPreferences.get("settings");
    if (data == null) {
      return null;
    }
    final mapsData = jsonDecode(data.toString()) as Map<String, dynamic>;
    return Settings.fromJson(mapsData);
  }


  Future<void> saveSlides(List<Slide> slide) async {
    await _sharedPreferences.remove("slide");
    final data = jsonEncode(slide.map((e) => e.toJson()).toList());
    await _sharedPreferences.setString("slide", data);
  }

  Future<List<Slide>?> getSlides() async {
    final data = _sharedPreferences.get("slide");
    if (data == null) {
      return null;
    }
     final mapsData = jsonDecode(data.toString()) as List<dynamic>;
    return mapsData
        .map((e) => Slide.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
