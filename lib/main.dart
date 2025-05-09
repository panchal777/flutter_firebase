import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AppRouter.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
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
