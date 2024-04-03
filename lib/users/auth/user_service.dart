import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = Provider((ref) => UserService(
    ref.read(sharedPrefranceServiceProvider),
    ref.read(supabaseUserRepositoryProvider)));

class UserService {
  final SharedPrefranceServce _prefranceServce;
  final SupabaseUserRepository _supabaseUserRepository;
  UserService(this._prefranceServce, this._supabaseUserRepository);
  Future<AppUser> loginAsVistor() async {
    final user = AppUser(
        fullName: "زائر",
        phone: "",
        username: "زائر",
        password: "",
        createdAt: DateTime.now(),
        type: UserType.anon);
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
    await _prefranceServce.deleteUserLocaly();
    AppUser? user = await _supabaseUserRepository.loginIn(username, password);
    if (user != null) {
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
    await _prefranceServce.deleteUserLocaly();
    await _prefranceServce.saveUser(updatesUser);
    return updatesUser;
  }
}
