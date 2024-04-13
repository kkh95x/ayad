import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'group.g.dart';

enum GroupType { customer, vistor }

enum SubType { groups, products }

@freezed
class Group with _$Group {
  const factory Group({
    String? id,
    required String name,
    required GroupType type,
    required SubType subType,
    required String parentGroupId,
    required DateTime createdAt,
    @Default(false) bool isMainGroup,
    String? hexColor,
    String? imageUrl,
    String? name2,
    double? priority,
    bool? isSeivce,
    String? referenceId,
    required bool isHiden,
  }) = _Group;

  factory Group.fromJson(Map<String, Object?> json) => _$GroupFromJson(json);
}
