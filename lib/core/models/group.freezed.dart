// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Group _$GroubFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroubCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroubCopyWith<$Res> {
  factory $GroubCopyWith(Group value, $Res Function(Group) then) =
      _$GroubCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({String? id, String name});
}

/// @nodoc
class _$GroubCopyWithImpl<$Res, $Val extends Group>
    implements $GroubCopyWith<$Res> {
  _$GroubCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroubImplCopyWith<$Res> implements $GroubCopyWith<$Res> {
  factory _$$GroubImplCopyWith(
          _$GroubImpl value, $Res Function(_$GroubImpl) then) =
      __$$GroubImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String name});
}

/// @nodoc
class __$$GroubImplCopyWithImpl<$Res>
    extends _$GroubCopyWithImpl<$Res, _$GroubImpl>
    implements _$$GroubImplCopyWith<$Res> {
  __$$GroubImplCopyWithImpl(
      _$GroubImpl _value, $Res Function(_$GroubImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_$GroubImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroubImpl with DiagnosticableTreeMixin implements _Group {
  const _$GroubImpl({this.id, required this.name});

  factory _$GroubImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroubImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Groub(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Groub'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroubImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroubImplCopyWith<_$GroubImpl> get copyWith =>
      __$$GroubImplCopyWithImpl<_$GroubImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroubImplToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  const factory _Group({final String? id, required final String name}) =
      _$GroubImpl;

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroubImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$GroubImplCopyWith<_$GroubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
