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

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  GroupType get type => throw _privateConstructorUsedError;
  SubType get subType => throw _privateConstructorUsedError;
  String get parentGroupId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isMainGroup => throw _privateConstructorUsedError;
  String? get hexColor => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get name2 => throw _privateConstructorUsedError;
  bool get isHiden => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {String? id,
      String name,
      GroupType type,
      SubType subType,
      String parentGroupId,
      DateTime createdAt,
      bool isMainGroup,
      String? hexColor,
      String? imageUrl,
      String? name2,
      bool isHiden});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? subType = null,
    Object? parentGroupId = null,
    Object? createdAt = null,
    Object? isMainGroup = null,
    Object? hexColor = freezed,
    Object? imageUrl = freezed,
    Object? name2 = freezed,
    Object? isHiden = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GroupType,
      subType: null == subType
          ? _value.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as SubType,
      parentGroupId: null == parentGroupId
          ? _value.parentGroupId
          : parentGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMainGroup: null == isMainGroup
          ? _value.isMainGroup
          : isMainGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      hexColor: freezed == hexColor
          ? _value.hexColor
          : hexColor // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name2: freezed == name2
          ? _value.name2
          : name2 // ignore: cast_nullable_to_non_nullable
              as String?,
      isHiden: null == isHiden
          ? _value.isHiden
          : isHiden // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      GroupType type,
      SubType subType,
      String parentGroupId,
      DateTime createdAt,
      bool isMainGroup,
      String? hexColor,
      String? imageUrl,
      String? name2,
      bool isHiden});
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? subType = null,
    Object? parentGroupId = null,
    Object? createdAt = null,
    Object? isMainGroup = null,
    Object? hexColor = freezed,
    Object? imageUrl = freezed,
    Object? name2 = freezed,
    Object? isHiden = null,
  }) {
    return _then(_$GroupImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GroupType,
      subType: null == subType
          ? _value.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as SubType,
      parentGroupId: null == parentGroupId
          ? _value.parentGroupId
          : parentGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMainGroup: null == isMainGroup
          ? _value.isMainGroup
          : isMainGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      hexColor: freezed == hexColor
          ? _value.hexColor
          : hexColor // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name2: freezed == name2
          ? _value.name2
          : name2 // ignore: cast_nullable_to_non_nullable
              as String?,
      isHiden: null == isHiden
          ? _value.isHiden
          : isHiden // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl with DiagnosticableTreeMixin implements _Group {
  const _$GroupImpl(
      {this.id,
      required this.name,
      required this.type,
      required this.subType,
      required this.parentGroupId,
      required this.createdAt,
      this.isMainGroup = false,
      this.hexColor,
      this.imageUrl,
      this.name2,
      required this.isHiden});

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final GroupType type;
  @override
  final SubType subType;
  @override
  final String parentGroupId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isMainGroup;
  @override
  final String? hexColor;
  @override
  final String? imageUrl;
  @override
  final String? name2;
  @override
  final bool isHiden;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Group(id: $id, name: $name, type: $type, subType: $subType, parentGroupId: $parentGroupId, createdAt: $createdAt, isMainGroup: $isMainGroup, hexColor: $hexColor, imageUrl: $imageUrl, name2: $name2, isHiden: $isHiden)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Group'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('subType', subType))
      ..add(DiagnosticsProperty('parentGroupId', parentGroupId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('isMainGroup', isMainGroup))
      ..add(DiagnosticsProperty('hexColor', hexColor))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('name2', name2))
      ..add(DiagnosticsProperty('isHiden', isHiden));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subType, subType) || other.subType == subType) &&
            (identical(other.parentGroupId, parentGroupId) ||
                other.parentGroupId == parentGroupId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isMainGroup, isMainGroup) ||
                other.isMainGroup == isMainGroup) &&
            (identical(other.hexColor, hexColor) ||
                other.hexColor == hexColor) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name2, name2) || other.name2 == name2) &&
            (identical(other.isHiden, isHiden) || other.isHiden == isHiden));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      subType,
      parentGroupId,
      createdAt,
      isMainGroup,
      hexColor,
      imageUrl,
      name2,
      isHiden);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  const factory _Group(
      {final String? id,
      required final String name,
      required final GroupType type,
      required final SubType subType,
      required final String parentGroupId,
      required final DateTime createdAt,
      final bool isMainGroup,
      final String? hexColor,
      final String? imageUrl,
      final String? name2,
      required final bool isHiden}) = _$GroupImpl;

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  GroupType get type;
  @override
  SubType get subType;
  @override
  String get parentGroupId;
  @override
  DateTime get createdAt;
  @override
  bool get isMainGroup;
  @override
  String? get hexColor;
  @override
  String? get imageUrl;
  @override
  String? get name2;
  @override
  bool get isHiden;
  @override
  @JsonKey(ignore: true)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
