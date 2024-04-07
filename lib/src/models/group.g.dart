// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      type: $enumDecode(_$GroupTypeEnumMap, json['type']),
      subType: $enumDecode(_$SubTypeEnumMap, json['subType']),
      parentGroupId: json['parentGroupId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isMainGroup: json['isMainGroup'] as bool? ?? false,
      hexColor: json['hexColor'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name2: json['name2'] as String?,
      priority: (json['priority'] as num?)?.toDouble(),
      isSeivce: json['isSeivce'] as bool?,
      isHiden: json['isHiden'] as bool,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$GroupTypeEnumMap[instance.type]!,
      'subType': _$SubTypeEnumMap[instance.subType]!,
      'parentGroupId': instance.parentGroupId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isMainGroup': instance.isMainGroup,
      'hexColor': instance.hexColor,
      'imageUrl': instance.imageUrl,
      'name2': instance.name2,
      'priority': instance.priority,
      'isSeivce': instance.isSeivce,
      'isHiden': instance.isHiden,
    };

const _$GroupTypeEnumMap = {
  GroupType.customer: 'customer',
  GroupType.vistor: 'vistor',
};

const _$SubTypeEnumMap = {
  SubType.groups: 'groups',
  SubType.products: 'products',
};
