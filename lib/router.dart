import 'package:ayad/core/models/group.dart';
import 'package:ayad/core/pages/group_page.dart';
import 'package:ayad/core/pages/home_page.dart';
import 'package:ayad/core/pages/login_page.dart';
import 'package:ayad/core/pages/splash_page.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/auth/auth_state.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref) {
  final authNotifer = ref.watch(authNotifierProvider).value;
  return GoRouter(
    observers: [BotToastNavigatorObserver()],
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routePath,
    routes: [
      GoRoute(
        path: SplashPage.routePath,
        name: SplashPage.routeName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: LoginPage.routePath,
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
       GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
       GoRoute(
        path: SubGroupPage.routePath,
        name: SubGroupPage.routeName,
        builder: (context, state) =>  SubGroupPage(group: state.extra as Group),
      )
    ],
    redirect: (context, state) {
      final isSplash = state.fullPath == SplashPage.routePath;
      final isAuth = authNotifer?.authStatus == AuthStatus.authorized;
      final isInit = authNotifer?.authStatus == AuthStatus.initial;
      if (isSplash) {
        if (isInit) {
          return null;
        } else {
          if (isAuth) {
            
            return HomePage.routePath;
          } else {
            return LoginPage.routePath;
          }
        }
      }
      return null;
    },
  );
});
