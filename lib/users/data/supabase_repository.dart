import 'package:ayad/users/data/user_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseUserRepositoryProvider =
    Provider((ref) => SupabaseUserRepository(Supabase.instance.client));

class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _supabaseClient;
  SupabaseUserRepository(this._supabaseClient);
  final _tableName = "users";
  @override
  Future<void> create(AppUser appUser) async {
    final data = appUser.toJson();
    data.remove("id");

    await _supabaseClient.from(_tableName).insert(data);
    return;
  }

  @override
  Future<bool> delete(String userId)async {
  await  _supabaseClient.from(_tableName).delete().eq("id", userId);
  return true;
  }

  @override
  Future<List<AppUser>?> getAll() async {
    final users = await _supabaseClient.from(_tableName).select();
    return users.map((e) => AppUser.fromJson(e)).toList();
  }

  @override
  Future<AppUser?> loginIn(String username, String password) {
    // TODO: implement loginIn
    throw UnimplementedError();
  }

  @override
  Future<AppUser> update(AppUser user) async {
    await _supabaseClient
        .from(_tableName)
        .update(user.toJson())
        .eq("id", user.id ?? "");
    return user;
  }

  @override
  Future<bool> checkUsername(String username) async {
    final count = await _supabaseClient
        .from(_tableName)
        .select("username")
        .eq("username", username)
        .count();
    return count.count > 0;
  }

  @override
  Future<bool> checkUsernameWithId(String username, String id) async {
    final count = await _supabaseClient
        .from(_tableName)
        .select("username")
        .neq("id", id)
        .eq("username", username)
        .count();
    return count.count > 0;
  }
}
