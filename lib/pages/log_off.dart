import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:gambit/pages/base_page.dart';

class LogOff extends StatelessWidget {
  const LogOff({super.key});

  Future<void> logOff() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // Remove stored values
    await sharedPreferences.remove('username');
    // Assuming 'rating' is the key used for storing the rating
    await sharedPreferences.remove('rating');
  }

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;

    void signUserOut() {
      logOff();
      FirebaseAuth.instance.signOut();
    }

    return IconButton(
      onPressed: signUserOut,
      icon: const Icon(Icons.logout_outlined, color: Colors.red),
    );
  }
}
