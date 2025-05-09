import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppRouter.init();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter.baseRouters,
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
