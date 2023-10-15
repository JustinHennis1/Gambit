import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';
//import 'package:gambit/pages/base_page.dart';

class LogOffText extends StatelessWidget {
  const LogOffText({super.key});
  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;

    void signUserOut() {
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
