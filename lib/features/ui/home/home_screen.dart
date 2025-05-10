import 'package:flutter/material.dart';

import '../../../core/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Welcome to Home'), centerTitle: true),
        body: Column(children: [Center(child: Text("Hey"))]),
        drawer: CustomDrawer(),
      ),
    );
  }
}
