import 'package:ayad/src/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final groupformProvider = Provider.family<FormGroup, Group?>((ref, group) {
  return FormGroup({
     'color': FormControl<Color>(value: ref.read(colorConverterProvider(group?.hexColor))),
    "name": FormControl<String>(
        value: group?.name, validators: [Validators.required]),
    "name2": FormControl<String>(
        value: group?.name2, validators: [Validators.required]),
    "groupCode": FormControl<String>(value: group?.groupCode),
    "isHidn":FormControl<bool>(value: group?.isHiden,validators: [Validators.required]),
    "groupNumber": FormControl<String>(value: group?.groupNumber)
  });
});
final colorConverterProvider=Provider.autoDispose.family<Color?,String?>((ref,hexColor){
  if(hexColor==null){
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
  }
 );