import 'package:ayad/src/data/slides_repository.dart';
import 'package:ayad/src/models/slides.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabaseSlideRepositoryProvider=Provider((ref) => SupabaseSlidesRepository(Supabase.instance.client));
class SupabaseSlidesRepository implements SlidesRepository {
  final String tableName = "slides";
  final SupabaseClient _supabaseClient;
  SupabaseSlidesRepository(this._supabaseClient);
  @override
  Future<void> create(Slide slide) async {
    final data = slide.toJson();
    data.remove("id");
    await _supabaseClient.from(tableName).insert(data);
  }

  @override
  Future<void> delete(String slideId) async {
    await _supabaseClient.from(tableName).delete().eq("id", slideId);
  }

  @override
  Future<List<Slide>> get({SlidesType? slidesType}) async {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query = _supabaseClient.from(tableName).select();
    if (slidesType != null) {
    query=query.eq("isHiden", false);
    query=  query.eq("slidesType", slidesType.name);
    }
    final res = await query.select();
    return res.map((e) => Slide.fromJson(e)).toList();
  }

  @override
  Future<void> update(Slide slide) async {
    await _supabaseClient
        .from(tableName)
        .update(slide.toJson())
        .eq("id", slide.id ?? "23");
  }
}
