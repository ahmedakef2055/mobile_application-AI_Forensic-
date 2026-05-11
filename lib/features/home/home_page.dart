import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home UI Ready ✅')),
    );
  }
}