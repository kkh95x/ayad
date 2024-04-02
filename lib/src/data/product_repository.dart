import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getSubProduct(String parentGroupId);
  Future<void> create(Product product);
  Future<void> update(Product product);
  Future<void> delete(String productId);
  Future<List<Product>> search(String? text,GroupType? type);
  
}