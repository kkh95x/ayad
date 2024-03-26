// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      authStatus: $enumDecode(_$AuthStatusEnumMap, json['authStatus']),
      currentUser: json['currentUser'] == null
          ? null
          : AppUser.fromJson(json['currentUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'authStatus': _$AuthStatusEnumMap[instance.authStatus]!,
      'currentUser': instance.currentUser,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.authorized: 'authorized',
  AuthStatus.unAuthorized: 'unAuthorized',
  AuthStatus.initial: 'initial',
};
