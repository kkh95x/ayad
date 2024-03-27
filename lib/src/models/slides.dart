import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'slides.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'slides.g.dart';

enum SlidesType { customer, vistor ,all}



@freezed
class Slide with _$Slide {
  const factory Slide({
    String? id,
    required String imageUrl,
    required String title,
    required SlidesType slidesType,
    required DateTime createdAt,
    @Default(false) bool isHiden,
    String? left,
    String? right,
  }) = _Slide;

  factory Slide.fromJson(Map<String, Object?> json) => _$SlideFromJson(json);
}
