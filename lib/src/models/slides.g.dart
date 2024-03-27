// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slides.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlideImpl _$$SlideImplFromJson(Map<String, dynamic> json) => _$SlideImpl(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      slidesType: $enumDecode(_$SlidesTypeEnumMap, json['slidesType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isHiden: json['isHiden'] as bool? ?? false,
      left: json['left'] as String?,
      right: json['right'] as String?,
    );

Map<String, dynamic> _$$SlideImplToJson(_$SlideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'slidesType': _$SlidesTypeEnumMap[instance.slidesType]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'isHiden': instance.isHiden,
      'left': instance.left,
      'right': instance.right,
    };

const _$SlidesTypeEnumMap = {
  SlidesType.customer: 'customer',
  SlidesType.vistor: 'vistor',
  SlidesType.all: 'all',
};
