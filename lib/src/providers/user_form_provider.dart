import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

final userformProvider = Provider.family<FormGroup, AppUser?>((ref, user) {
  return FormGroup({
    "fullName": FormControl<String>(
        value: user?.fullName, validators: [Validators.required]),
    "phone": FormControl<PhoneNumber>(
        value: user != null ? PhoneNumber.parse(user.phone) : null,
        validators: [Validators.required]),
    "username": FormControl<String>(
        value: user?.username,
        validators: [Validators.required, Validators.minLength(6)]),
    "password": FormControl<String>(
        value: user?.password,
        validators: [Validators.required, Validators.minLength(8)]),
    // "isAdminEnum": FormControl<UserType>(
    //     value: user?.type, validators: [Validators.required]),
    "isAdmin": FormControl<bool>(
        value: user != null && user.type == UserType.admin,
        validators: [Validators.required]),
  });
});
final userPasswordformProvider = Provider<FormGroup>((ref) {
  return FormGroup({
    "password": FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
    "password2": FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
    "password3": FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
  }, validators: [
    Validators.compare("password3", "password2", CompareOption.equal)
  ]);
});
