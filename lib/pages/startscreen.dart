import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import 'startscreenstyle.dart';
import 'auth_page.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    // Timed animation for logo
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const AuthPage().animate().slideY()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.blue, // Customize background color
        body: StartScreenStyle(
          Color.fromARGB(255, 77, 50, 4),
          Color.fromARGB(255, 248, 203, 68),
        ));
  }
}
