import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'group.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    String? id,
    required String name,
    required String name2,
    required bool isHiden,
    String? groupCode,
    String? groupNumber,
    

  }) = _Group;

  factory Group.fromJson(Map<String, Object?> json)
      => _$GroupFromJson(json);
}