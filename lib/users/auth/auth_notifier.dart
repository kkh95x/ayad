import 'dart:async';

import 'package:ayad/users/auth/auth_state.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() async {
    state = const AsyncData(AuthState(authStatus: AuthStatus.initial));
    await Future.delayed(
      const Duration(seconds: 2),
      () {},
    );
    return const AuthState(authStatus: AuthStatus.unAuthorized);
  }

  login() async {
    BotToast.showLoading();
    await Future.delayed(const Duration(seconds: 2));
    BotToast.closeAllLoading();
    state = const AsyncData(AuthState(authStatus: AuthStatus.authorized));
  }

  logout() async {
    BotToast.showLoading();
    await Future.delayed(const Duration(seconds: 2));
    BotToast.closeAllLoading();
    state = const AsyncData(AuthState(authStatus: AuthStatus.unAuthorized));
  }
}
