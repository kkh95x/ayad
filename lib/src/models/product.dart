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
      required String groupName,
      required String nameArabic,
      required String nameEnglis,
      required double price,
      String? productCode,
      @Default(false) bool isHiden,
      double? count,
      String? imageUrl,
      String? type,
      bool? makfol,
    
      String? description}) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
