import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart' show RouteName;
import 'package:go_router/go_router.dart';

import '../../../core/utils/common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }

  void isLogin() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      await Common.saveUserDetails(user.uid);
      if (!mounted) return; // ✅ Prevent using context if widget is disposed
      context.go(RouteName.dashboard);
    } else {
      if (!mounted) return;
      context.go(RouteName.login);
    }
  }
}
