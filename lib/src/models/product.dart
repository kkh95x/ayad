import 'package:ayad/src/models/group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {String? id,
      required String productName,
      required String productFullName,
      required String parentGroupId,
      required DateTime createdAt,
      required GroupType groupType,
      String? productsSearching1,
      String? productsSearching2,
      String? productsSearching3,
      String? productsSearching4,
      required double price,
      @Default(false) bool isHiden,
      double? count,
      String? imageUrl,
      String? type,
      bool? makfol,
      double? priority,
          String? referenceId,

      String? description}) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
