import 'package:ayad/src/data/product_repository.dart';
import 'package:ayad/src/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabaseProductRepositoryProvider=Provider((ref) => SupabaseProductRepository(Supabase.instance.client));
class SupabaseProductRepository implements ProductRepository {
  SupabaseProductRepository(this._client);
 final  SupabaseClient _client;
  final String tableName="products";
  @override
  Future<void> create(Product product) async{
    final data=product.toJson();
    data.remove('id');
    await _client.from(tableName).insert(data);

  }

  @override
  Future<void> delete(String productId) async{
    await _client.from(tableName).delete().eq("id", productId);
  }

  @override
  Future<List<Product>> getSubProduct(String parentGroupId) async{
    final data=await _client.from(tableName).select().eq("parentGroupId", parentGroupId);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<void> update(Product product) async{
    await _client.from(tableName).update(product.toJson()).eq("id", product.id??"34");
  }
  
}