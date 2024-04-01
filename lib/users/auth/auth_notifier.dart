import 'dart:async';

import 'package:ayad/users/auth/auth_state.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:ayad/users/auth/user_service.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthNotifier();
  @override
  FutureOr<AuthState> build() async {
    state = AsyncData(AuthState(authStatus: AuthStatus.initial));
    final service = ref.read(userServiceProvider);
    final user = await service.getCurrentUser();
    if (user == null) {
      // state = AsyncData(AuthState(authStatus: AuthStatus.unAuthorized));
      await Future.delayed(const Duration(milliseconds: 200));

      return AuthState(authStatus: AuthStatus.unAuthorized);
    }
    if (user.type == UserType.anon) {
      await Future.delayed(const Duration(milliseconds: 200));
      return AuthState(authStatus: AuthStatus.authorized, currentUser: user);
    } else {
      try {
        final currentUser = await ref
            .read(userServiceProvider)
            .getUserByUsenamAndPassword(user.username, user.password);
        if (currentUser == null) {
          return AuthState(authStatus: AuthStatus.unAuthorized);
        } else {
          ref.read(sharedPrefranceServiceProvider).saveUser(currentUser);
          return AuthState(
              authStatus: AuthStatus.authorized, currentUser: currentUser);
        }
      } catch (e) {
        return AuthState(authStatus: AuthStatus.authorized, currentUser: user);
      }
    }
  }

  Future<void> login(FormGroup formGroup) async {
    final service = ref.read(userServiceProvider);

    BotToast.showLoading();
    final user = await service.getUserByUsenamAndPassword(
        formGroup.control("username").value,
        formGroup.control("password").value);
    if (user == null) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "خطأ أسم المستخدم أو كلمة السر");
      state = AsyncData(AuthState(authStatus: AuthStatus.unAuthorized));
      return;
    }

    BotToast.closeAllLoading();
    state = AsyncData(
        AuthState(authStatus: AuthStatus.authorized, currentUser: user));
  }

  logout() async {
    BotToast.showLoading();
    final service = ref.read(userServiceProvider);
    await service.logout();
    BotToast.closeAllLoading();
    state = AsyncData(AuthState(authStatus: AuthStatus.unAuthorized));
  }

  loginAsVistor() async {
    BotToast.showLoading();
    final service = ref.read(userServiceProvider);
    final user = await service.loginAsVistor();
    BotToast.closeAllLoading();
    state = AsyncData(
        AuthState(authStatus: AuthStatus.authorized, currentUser: user));
  }
}
