import 'package:ayad/src/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final groupformProvider = Provider.family<FormGroup, Group?>((ref, group) {
  return FormGroup({
    "name": FormControl<String>(
        value: group?.name, validators: [Validators.required]),
    "name2": FormControl<String>(
        value: group?.name2, validators: [Validators.required]),
    "groupCode": FormControl<String>(value: group?.groupCode),
    "isHidn":FormControl<bool>(value: group?.isHiden,validators: [Validators.required]),
    "groupNumber": FormControl<String>(value: group?.groupNumber)
  });
});
