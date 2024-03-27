import 'package:ayad/src/models/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

final settingsformProvider =
    Provider.family<FormGroup, Settings?>((ref, setting) {
//   fixedId
// apkUrl
// whatsAppPhone
// landtute
// longtute
// messageForCoustomer
// messageForVisotr
// noteForParts
// minVersion
  return FormGroup({
    "messageForVisotr": FormControl<String>(
        value: setting?.messageForVisotr, validators: [Validators.required]),
    "messageForCoustomer": FormControl<String>(
        value: setting?.messageForCoustomer, validators: [Validators.required]),
    "noteForParts": FormControl<String>(
        value: setting?.messageForCoustomer, validators: [Validators.required]),
    "whatsAppPhone": FormControl<PhoneNumber>(
        value:
            setting != null ? PhoneNumber.parse(setting.whatsAppPhone) : null,
        validators: [Validators.required]),
    "minVersin": FormControl<String>(
        value: setting?.minVersion, validators: [Validators.required]),
    "apkUrl": FormControl<String>(
        value: setting?.apkUrl, validators: [Validators.required]),
    "landtute": FormControl<double>(
        value: setting?.landtute, validators: [Validators.required]),
    "longtute": FormControl<double>(
        value: setting?.longtute, validators: [Validators.required]),
  });
});
