import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

final userServiceProvider = Provider((ref) => UserService(
    ref.read(sharedPrefranceServiceProvider),
    ref.read(supabaseUserRepositoryProvider)));

class UserService {
  final SharedPrefranceServce _prefranceServce;
  final SupabaseUserRepository _supabaseUserRepository;
  UserService(this._prefranceServce, this._supabaseUserRepository);
  String generateRandomNumber() {
    Random random = Random();
    String randomNumber = '';

    for (int i = 0; i < 10; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }

  Future<AppUser> loginAsVistor() async {
    final usename = "زائر${generateRandomNumber()}";
    final password = generateRandomNumber();
    AppUser user = AppUser(
        fullName: "زائر",
        phone: "",
        username: usename,
        password: password,
        createdAt: DateTime.now(),
        type: UserType.anon);
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        user = user.copyWith(token: fcmToken);
      }
      await _supabaseUserRepository.create(user);
      final userWithId = await _supabaseUserRepository.getId(usename, password);
      user = userWithId!;
      await _prefranceServce.saveUser(user);
    } catch (e) {
      if (kDebugMode) {
        print("r-->${e.toString()}");
      }
    }
    await _supabaseUserRepository.create(user);
    await _prefranceServce.saveUser(user);
    return user;
  }

  Future<AppUser?> getCurrentUser() async {
    final currentUser = await _prefranceServce.getUser();
    // if(currentUser!=null){
    //   Future(() {
    //     final userFormInternet
    //   });
    // }
    return currentUser;
  }

  Future<void> logout() async {
    await _prefranceServce.deleteUserLocaly();
    await _prefranceServce.clearAll();
  }

  Future<AppUser?> getUserByUsenamAndPassword(
      String username, String password) async {
    AppUser? user = await _supabaseUserRepository.loginIn(username, password);
    if (user != null) {
      await _prefranceServce.deleteUserLocaly();

      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          user = user.copyWith(token: fcmToken);
          await _supabaseUserRepository.update(user);
        }
      } catch (e) {
        if (kDebugMode) {
          print("r-->${e.toString()}");
        }
      }
      await _prefranceServce.saveUser(user!);
    }
    return user;
  }

  Future<AppUser> updateUser(String password, AppUser appUser) async {
    final updatesUser = appUser.copyWith(password: password);
    await _supabaseUserRepository.update(updatesUser);
    // await _prefranceServce.deleteUserLocaly();
    await _prefranceServce.saveUser(updatesUser);
    return updatesUser;
  }
}
