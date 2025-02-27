import 'package:ayad/src/data/group_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseGroupRepositoryProvider =
    Provider((ref) => SupabaseGroupRepository(Supabase.instance.client));

class SupabaseGroupRepository implements GroupRepository {
  SupabaseGroupRepository(this._supabaseClient);
  final _tableName = "groups";
  final SupabaseClient _supabaseClient;
  @override
  Future<void> create(Group group) async {
    try {
      final data = group.toJson();
      data.remove("id");
      await _supabaseClient.from(_tableName).insert(data);
    } catch (e) {
      if (e is PostgrestException) {
        // print("--->${e.message}");
      }
      // print("--->${e.toString()}");
    }
  }

  @override
  Future<void> delete(String groupId) async {
    await _supabaseClient.from(_tableName).delete().eq("id", groupId);
  }

  @override
  Future<List<Group>> getMainGroup(
      {required GroupType? groupType, bool? isHiden}) async {
    // if (isHiden == null) {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
        _supabaseClient.from(_tableName).select().eq("isMainGroup", true);
    if (groupType != null) {
     query= query.eq("type", groupType.name);
    }
    if (isHiden != null) {
     query= query.eq("isHiden", isHiden);
    }
    // .eq("type", groupType.name);
    final response = await query.order("priority",ascending: false);
    return response.map((e) => Group.fromJson(e)).toList();
    // } else {
    //   final response = await _supabaseClient
    //       .from(_tableName)
    //       .select()
    //       .eq("isMainGroup", true)
    //       .eq("type", groupType.name)
    //       .eq("isHiden", isHiden);
    //   return response.map((e) => Group.fromJson(e)).toList();
    // }
  }

  @override
  Future<void> update(Group group) async {
    await _supabaseClient
        .from(_tableName)
        .update(group.toJson())
        .eq("id", group.id ?? "");
  }

  @override
  Future<List<Group>> getSubGruops(String parentGroupId,{bool? isHidden}) async {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query = _supabaseClient
        .from(_tableName)
        .select()
        .eq("isMainGroup", false)
        .eq("parentGroupId", parentGroupId);
    if(isHidden!=null){
      query=query.eq("isHiden", isHidden);
    }
    final res = await query.order("priority",ascending: false);
    return res.map((e) => Group.fromJson(e)).toList();
  }
}
