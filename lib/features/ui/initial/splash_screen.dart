import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart' show RouteName;
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }

  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        context.go(RouteName.dashboard);
      } else {
        context.go(RouteName.login);
      }
    });
  }
}
