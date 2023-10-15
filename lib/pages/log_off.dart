import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:gambit/pages/base_page.dart';

class LogOff extends StatelessWidget {
  const LogOff({super.key});
  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;

    void signUserOut() {
      FirebaseAuth.instance.signOut();
    }

    return IconButton(
      onPressed: signUserOut,
      icon: const Icon(Icons.logout_outlined, color: Colors.red),
    );
  }
}
