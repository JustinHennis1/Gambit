import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gambit/components/texttheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:gambit/pages/base_page.dart';

class LogOffText extends StatelessWidget {
  const LogOffText({super.key});

  Future<void> logOff() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove('email');
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

    return TextButton(
      onPressed: signUserOut,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      child: const ListTileTheme2('Log Out'),
    );
  }
}
