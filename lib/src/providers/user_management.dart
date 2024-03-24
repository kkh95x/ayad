import 'package:ayad/users/data/supabase_repository.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

final userManagmentProvider =
    StateNotifierProvider<UserManagementNotifer, AsyncValue<List<AppUser>?>>(
        (ref) =>
            UserManagementNotifer(ref.read(supabaseUserRepositoryProvider)));

class UserManagementNotifer extends StateNotifier<AsyncValue<List<AppUser>?>> {
  UserManagementNotifer(this._userRepository) : super(const AsyncLoading()) {
    _init();
  }
  final SupabaseUserRepository _userRepository;
  _init() async {
    state = const AsyncLoading();
    final users = await _userRepository.getAll();
    state = AsyncData(users);
  }

  Future<void> addUser(FormGroup formGroup) async {
    if (formGroup.invalid) {
      BotToast.showText(text: "يرجى التأكد من البيانات والمحاولة مجدداََ");
      return;
    }
    final user = AppUser(
        fullName: formGroup.control("fullName").value.toString(),
        phone: (formGroup.control("phone").value as PhoneNumber).international,
        username: formGroup.control("username").value.toString(),
        password: formGroup.control("password").value.toString(),
        createdAt: DateTime.now(),
        type: formGroup.control("isAdmin").value as bool
            ? UserType.admin
            : UserType.customer);
    BotToast.showLoading();
    if (await _userRepository.checkUsername(user.username)) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "اسم المستخدم موجود يرجى إختيار اسم أخر");
      return;
    }
    await _userRepository.create(user);
    BotToast.closeAllLoading();
    BotToast.showText(text: "تم إضافة المستخدم بنجاح");
    _init();
  }

  Future<void> updateUser(FormGroup formGroup, AppUser user) async {
    if (formGroup.invalid) {
      BotToast.showText(text: "يرجى التأكد من البيانات والمحاولة مجدداََ");
      return;
    }
    final newUser = user.copyWith(
        fullName: formGroup.control("fullName").value.toString(),
        phone: (formGroup.control("phone").value as PhoneNumber).international,
        username: formGroup.control("username").value.toString(),
        password: formGroup.control("password").value.toString(),
        createdAt: DateTime.now(),
        type: formGroup.control("isAdmin").value as bool
            ? UserType.admin
            : UserType.customer);
    BotToast.showLoading();
    if (await _userRepository.checkUsernameWithId(
        newUser.username, user.id ?? "")) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "اسم المستخدم موجود يرجى إختيار اسم أخر");
      return;
    }
    await _userRepository.update(newUser);
    BotToast.closeAllLoading();
    BotToast.showText(text: "تم تحديث المستخدم بنجاح");
    _init();
  }

  Future<bool?> delete(String userId, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("تحذير"),
          content:
              const Text("أنت على وشك حذف الزبون نهائياََ , هل تريد المتابعة؟"),
          actions: [
            TextButton(
                onPressed: () async {
                  BotToast.showLoading();
                  await _userRepository.delete(userId);
                  BotToast.closeAllLoading();
                  _init();
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                },
                child: const Text("نعم")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("لا"))
          ],
        );
      },
    );
  }
}
