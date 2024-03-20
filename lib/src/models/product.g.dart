// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String?,
      groupName: json['groupName'] as String,
      nameArabic: json['nameArabic'] as String,
      nameEnglis: json['nameEnglis'] as String,
      price: (json['price'] as num).toDouble(),
      productCode: json['productCode'] as String?,
      isHiden: json['isHiden'] as bool? ?? false,
      count: (json['count'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String?,
      makfol: json['makfol'] as bool?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupName': instance.groupName,
      'nameArabic': instance.nameArabic,
      'nameEnglis': instance.nameEnglis,
      'price': instance.price,
      'productCode': instance.productCode,
      'isHiden': instance.isHiden,
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'type': instance.type,
      'makfol': instance.makfol,
      'description': instance.description,
    };
