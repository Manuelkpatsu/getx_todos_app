import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splashscreen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
