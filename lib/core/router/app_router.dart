import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart' show RouteName;
import 'package:flutter_firebase/features/presentation/initial/splash_screen.dart'
    show SplashScreen;
import 'package:flutter_firebase/features/presentation/login/pages/login_page.dart';
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;

class AppRouter {
  AppRouter._();

  /// Key so we can navigate without context.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /*----------------------------------------*/

  static GoRouter? _baseRoutes;

  static GoRouter get baseRouters => _baseRoutes!;

  static List<GoRoute> get routes => _routes;

  static void init() {
    _baseRoutes = GoRouter(
      navigatorKey: navigatorKey,
      //observers: routeObservers,
      routes: <GoRoute>[...routes],
      redirect: (context, state) {
        log('url => ${state.uri.toString()}');
        return null;
      },
    );
  }

  static final _routes = <GoRoute>[
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) {
        return SplashScreen();
      },
      routes: [
        GoRoute(
          name: RouteName.login,
          path: RouteName.login,
          builder: (context, state) => LoginPage(),
        ),
      ],
    ),
  ];
}
