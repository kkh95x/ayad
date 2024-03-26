import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final userServiceProvider = Provider((ref) => UserService(
    ref.read(sharedPrefranceServiceProvider),
    ref.read(supabaseUserRepositoryProvider)));

class UserService {
  final SharedPrefranceServce _prefranceServce;
  final SupabaseUserRepository _supabaseUserRepository;
  UserService(this._prefranceServce, this._supabaseUserRepository);

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

  Future<AppUser?> getUserByUsenamAndPassword(FormGroup formGroup) async {
    if (formGroup.invalid) {
      return null;
    }
    final username = formGroup.control("username").value.toString();
    final password = formGroup.control("password").value.toString();

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
