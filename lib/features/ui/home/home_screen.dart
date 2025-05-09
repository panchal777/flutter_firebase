import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Home'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Column(children: [Center(child: Text("Hey"))]),
    );
  }
}
