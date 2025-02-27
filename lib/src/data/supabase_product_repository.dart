import 'package:ayad/src/data/product_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProductRepositoryProvider =
    Provider((ref) => SupabaseProductRepository(Supabase.instance.client));

class SupabaseProductRepository implements ProductRepository {
  SupabaseProductRepository(this._client);
  final SupabaseClient _client;
  final String tableName = "products";
  @override
  Future<void> create(Product product) async {
    final data = product.toJson();
    data.remove('id');
    await _client.from(tableName).insert(data);
  }

  @override
  Future<void> delete(String productId) async {
    await _client.from(tableName).delete().eq("id", productId);
  }

  @override
  Future<List<Product>> getSubProduct(String parentGroupId,
      {bool? isHiden}) async {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
        _client.from(tableName).select().eq("parentGroupId", parentGroupId);
    if (isHiden != null) {
      query = query.eq("isHiden", isHiden);
    }
    final data = await query.order("priority", ascending: false);

    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<void> update(Product product) async {
    await _client
        .from(tableName)
        .update(product.toJson())
        .eq("id", product.id ?? "34");
  }

  @override
  Future<List<Product>> search(
      String? text, GroupType? type, Group? group) async {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
        _client.from(tableName).select();
    if (type != null) {
      query = query.eq("groupType", type.name);
    }
    if (text != null && text.isNotEmpty) {
      query = query.or(
          "productFullName.like.%$text%,productName.like.%$text%,productsSearching1.like.%$text%,productsSearching2.like.%$text%,productsSearching3.like.%$text%,productsSearching4.like.%$text%");
    }
    if (group != null) {
      query =
          query.like("referenceId", "${group.referenceId ?? ""}${group.id}%");
    }
    final res = await query;
    return res.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Product?> get(String id, GroupType groupType) async {
    final res = await _client
        .from(tableName)
        .select()
        .eq("isHiden", false)
        .eq("groupType", groupType.name)
        .eq("id", id)
        .single();
    if (res.isEmpty) {
      return null;
    } else {
      return Product.fromJson(res);
    }
  }
}
