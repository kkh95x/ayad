import 'package:ayad/src/models/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';



final settingsformProvider = Provider.family<FormGroup, Settings?>((ref, setting) {
  return FormGroup({
    "marketInfo": FormControl<String>(
        value: setting?.marketInfo, validators: [Validators.required]),
    "whatsAppPhone": FormControl<PhoneNumber>(
        value:
            setting != null ? PhoneNumber.parse(setting.whatsAppPhone) : null,
        validators: [Validators.required]),
    "minVersin": FormControl<String>(
        value: setting?.minVersion, validators: [Validators.required]),
    "appUrl": FormControl<String>(
        value: setting?.appUrl, validators: [Validators.required]),
  });
});
