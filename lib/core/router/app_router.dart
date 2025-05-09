import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart' show RouteName;
import 'package:flutter_firebase/features/ui/authentication/forget_password/forgot_password_screen.dart';
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;

import '../../features/ui/authentication/login/screens/login_screen.dart';
import '../../features/ui/authentication/signup_screen/sign_up_screen.dart';
import '../../features/ui/home/home_screen.dart';
import '../../features/ui/initial/splash_screen.dart';

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
      initialLocation: '/splash',
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
      path: RouteName.initialRoute,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: RouteName.login,
      path: RouteName.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: RouteName.signUp,
      path: RouteName.signUp,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      name: RouteName.forgotPassword,
      path: RouteName.forgotPassword,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      name: RouteName.dashboard,
      path: RouteName.dashboard,
      builder: (context, state) => HomeScreen(),
    ),
  ];
}
