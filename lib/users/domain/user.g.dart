// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
      'createdAt': instance.createdAt.toIso8601String(),
      'type': _$UserTypeEnumMap[instance.type]!,
      'token': instance.token,
    };

const _$UserTypeEnumMap = {
  UserType.anon: 'anon',
  UserType.admin: 'admin',
  UserType.customer: 'customer',
};
