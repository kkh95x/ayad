// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      name2: json['name2'] as String,
      isMainGroup: json['isMainGroup'] as bool? ?? false,
      hexColor: json['hexColor'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isHiden: json['isHiden'] as bool,
      groupCode: json['groupCode'] as String?,
      groupNumber: json['groupNumber'] as String?,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name2': instance.name2,
      'isMainGroup': instance.isMainGroup,
      'hexColor': instance.hexColor,
      'imageUrl': instance.imageUrl,
      'isHiden': instance.isHiden,
      'groupCode': instance.groupCode,
      'groupNumber': instance.groupNumber,
    };
