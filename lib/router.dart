import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/pages/group_page.dart';
import 'package:ayad/src/pages/home_page.dart';
import 'package:ayad/src/pages/login_page.dart';
import 'package:ayad/src/pages/product_page.dart';
import 'package:ayad/src/pages/products_page.dart';
import 'package:ayad/src/pages/profile_page.dart';
import 'package:ayad/src/pages/splash_page.dart';
import 'package:ayad/src/pages/users_page.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/auth/auth_state.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
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
        builder: (context, state) => SplashPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: LoginPage.routePath,
        name: LoginPage.routeName,
        builder: (context, state) => LoginPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (context, state) => HomePage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SubGroupPage.routePath,
        name: SubGroupPage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child:
                SubGroupPage(key: state.pageKey, group: state.extra as Group)),

        // builder: (context, state) => SubGroupPage(group: state.extra as Group),
      ),
      GoRoute(
        path: ProductsPage.routePath,
        name: ProductsPage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child:
                ProductsPage(key: state.pageKey, group: state.extra as Group)),
      ),
      GoRoute(
        path: ProfilePage.routePath,
        name: ProfilePage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child:
                ProfilePage(key: state.pageKey,)),
      ),
      GoRoute(
        path: UsersPage.routePath,
        name: UsersPage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child:
                UsersPage(key: state.pageKey,)),
      ),
      GoRoute(
        path: ProductPage.routePath,
        name: ProductPage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: ProductPage(
                key: state.pageKey, product: state.extra as Product)),
        // builder: (context, state) => widget(
        //   child:
        //       ProductPage(key: state.pageKey, product: state.extra as Product),
        // ),
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

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-0.1, 0.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      });
}

CustomTransitionPage buildPageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
     
        return FadeTransition(opacity: animation, child: child);
      });
}




CustomTransitionPage buildPageWitTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.1);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      });
}