// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slides.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Slide _$SlideFromJson(Map<String, dynamic> json) {
  return _Slide.fromJson(json);
}

/// @nodoc
mixin _$Slide {
  String? get id => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  SlidesType get slidesType => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isHiden => throw _privateConstructorUsedError;
  String? get left => throw _privateConstructorUsedError;
  String? get right => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlideCopyWith<Slide> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideCopyWith<$Res> {
  factory $SlideCopyWith(Slide value, $Res Function(Slide) then) =
      _$SlideCopyWithImpl<$Res, Slide>;
  @useResult
  $Res call(
      {String? id,
      String imageUrl,
      String title,
      SlidesType slidesType,
      DateTime createdAt,
      bool isHiden,
      String? left,
      String? right});
}

/// @nodoc
class _$SlideCopyWithImpl<$Res, $Val extends Slide>
    implements $SlideCopyWith<$Res> {
  _$SlideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUrl = null,
    Object? title = null,
    Object? slidesType = null,
    Object? createdAt = null,
    Object? isHiden = null,
    Object? left = freezed,
    Object? right = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slidesType: null == slidesType
          ? _value.slidesType
          : slidesType // ignore: cast_nullable_to_non_nullable
              as SlidesType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isHiden: null == isHiden
          ? _value.isHiden
          : isHiden // ignore: cast_nullable_to_non_nullable
              as bool,
      left: freezed == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String?,
      right: freezed == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlideImplCopyWith<$Res> implements $SlideCopyWith<$Res> {
  factory _$$SlideImplCopyWith(
          _$SlideImpl value, $Res Function(_$SlideImpl) then) =
      __$$SlideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String imageUrl,
      String title,
      SlidesType slidesType,
      DateTime createdAt,
      bool isHiden,
      String? left,
      String? right});
}

/// @nodoc
class __$$SlideImplCopyWithImpl<$Res>
    extends _$SlideCopyWithImpl<$Res, _$SlideImpl>
    implements _$$SlideImplCopyWith<$Res> {
  __$$SlideImplCopyWithImpl(
      _$SlideImpl _value, $Res Function(_$SlideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUrl = null,
    Object? title = null,
    Object? slidesType = null,
    Object? createdAt = null,
    Object? isHiden = null,
    Object? left = freezed,
    Object? right = freezed,
  }) {
    return _then(_$SlideImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slidesType: null == slidesType
          ? _value.slidesType
          : slidesType // ignore: cast_nullable_to_non_nullable
              as SlidesType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isHiden: null == isHiden
          ? _value.isHiden
          : isHiden // ignore: cast_nullable_to_non_nullable
              as bool,
      left: freezed == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String?,
      right: freezed == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlideImpl with DiagnosticableTreeMixin implements _Slide {
  const _$SlideImpl(
      {this.id,
      required this.imageUrl,
      required this.title,
      required this.slidesType,
      required this.createdAt,
      this.isHiden = false,
      this.left,
      this.right});

  factory _$SlideImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlideImplFromJson(json);

  @override
  final String? id;
  @override
  final String imageUrl;
  @override
  final String title;
  @override
  final SlidesType slidesType;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isHiden;
  @override
  final String? left;
  @override
  final String? right;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Slide(id: $id, imageUrl: $imageUrl, title: $title, slidesType: $slidesType, createdAt: $createdAt, isHiden: $isHiden, left: $left, right: $right)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Slide'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('slidesType', slidesType))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('isHiden', isHiden))
      ..add(DiagnosticsProperty('left', left))
      ..add(DiagnosticsProperty('right', right));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slidesType, slidesType) ||
                other.slidesType == slidesType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isHiden, isHiden) || other.isHiden == isHiden) &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.right, right) || other.right == right));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl, title, slidesType,
      createdAt, isHiden, left, right);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideImplCopyWith<_$SlideImpl> get copyWith =>
      __$$SlideImplCopyWithImpl<_$SlideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlideImplToJson(
      this,
    );
  }
}

abstract class _Slide implements Slide {
  const factory _Slide(
      {final String? id,
      required final String imageUrl,
      required final String title,
      required final SlidesType slidesType,
      required final DateTime createdAt,
      final bool isHiden,
      final String? left,
      final String? right}) = _$SlideImpl;

  factory _Slide.fromJson(Map<String, dynamic> json) = _$SlideImpl.fromJson;

  @override
  String? get id;
  @override
  String get imageUrl;
  @override
  String get title;
  @override
  SlidesType get slidesType;
  @override
  DateTime get createdAt;
  @override
  bool get isHiden;
  @override
  String? get left;
  @override
  String? get right;
  @override
  @JsonKey(ignore: true)
  _$$SlideImplCopyWith<_$SlideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
