import 'package:flutter/material.dart';
import 'package:wikidados_teste/pages/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  final int duration = 3;
  final Widget goToPage = const Login();

  @override
  Widget build(BuildContext context) {
    // After durations time, changes page
    Future.delayed(Duration(seconds: duration), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => goToPage));
    });

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Image.asset(
              "assets/images/download.jpg",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
