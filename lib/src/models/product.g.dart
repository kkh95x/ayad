// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String?,
      productName: json['productName'] as String,
      productFullName: json['productFullName'] as String,
      parentGroupId: json['parentGroupId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      groupType: $enumDecode(_$GroupTypeEnumMap, json['groupType']),
      productsSearching1: json['productsSearching1'] as String?,
      productsSearching2: json['productsSearching2'] as String?,
      productsSearching3: json['productsSearching3'] as String?,
      productsSearching4: json['productsSearching4'] as String?,
      price: (json['price'] as num).toDouble(),
      isHiden: json['isHiden'] as bool? ?? false,
      count: (json['count'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String?,
      makfol: json['makfol'] as bool?,
      priority: (json['priority'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'productFullName': instance.productFullName,
      'parentGroupId': instance.parentGroupId,
      'createdAt': instance.createdAt.toIso8601String(),
      'groupType': _$GroupTypeEnumMap[instance.groupType]!,
      'productsSearching1': instance.productsSearching1,
      'productsSearching2': instance.productsSearching2,
      'productsSearching3': instance.productsSearching3,
      'productsSearching4': instance.productsSearching4,
      'price': instance.price,
      'isHiden': instance.isHiden,
      'count': instance.count,
      'imageUrl': instance.imageUrl,
      'type': instance.type,
      'makfol': instance.makfol,
      'priority': instance.priority,
      'description': instance.description,
    };

const _$GroupTypeEnumMap = {
  GroupType.customer: 'customer',
  GroupType.vistor: 'vistor',
};
