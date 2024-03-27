import 'package:ayad/src/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final groupformProvider = Provider.family<FormGroup, Group?>((ref, group) {

  return FormGroup({
    "type": FormControl<GroupType>(value: group?.type),
    "subType": FormControl<SubType>(value: group?.subType,validators: [Validators.required]),
    "imageUrl": FormControl<String>(value: group?.imageUrl),
    'color': FormControl<Color>(
        value: ref.read(colorConverterProvider(group?.hexColor))),
    "name": FormControl<String>(
        value: group?.name, validators: [Validators.required]),
    "name2": FormControl<String>(
        value: group?.name2, ),
    "isHidn": FormControl<bool>(
        value: group?.isHiden??false,),
  });
});
final colorConverterProvider =
    Provider.autoDispose.family<Color?, String?>((ref, hexColor) {
  if (hexColor == null) {
    return null;
  }
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }

  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }

  return null;
});
