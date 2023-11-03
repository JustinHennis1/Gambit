import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:gambit/pages/log_off.dart';
import 'package:gambit/pages/basescreen.dart';

import 'package:gambit/pages/login_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            return const BaseScreen(0).animate().fadeIn(duration: 100.ms);
          } else {
            return const LoginPage().animate().fadeIn(duration: 100.ms);
          }
        },
      ),
    );
  }
}
