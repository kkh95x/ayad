import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
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
  }

  Future<AppUser?> getUserByUsenamAndPassword(
      String username, String password) async {
    await _prefranceServce.deleteUserLocaly();
    final user = await _supabaseUserRepository.loginIn(username, password);
    if (user != null) {
      await _prefranceServce.saveUser(user);
    }
    return user;
  }

  Future<(AppUser, bool)> updateUser(String password, AppUser appUser) async {
    if (appUser.password != password) {
      return (appUser, false);
    }
    final updatesUser = appUser.copyWith(password: password);
    await _supabaseUserRepository.update(updatesUser);
    await _prefranceServce.deleteUserLocaly();
    await _prefranceServce.saveUser(updatesUser);
    return (updatesUser, true);
  }
}
