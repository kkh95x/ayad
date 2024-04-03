// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AppNotificationImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      senderId: json['senderId'] as String,
      productId: json['productId'] as String?,
      isSeen: json['isSeen'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppNotificationImplToJson(
        _$AppNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userId,
      'createAt': instance.createAt.toIso8601String(),
      'senderId': instance.senderId,
      'productId': instance.productId,
      'isSeen': instance.isSeen,
    };
