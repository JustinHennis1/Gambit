import 'package:flutter/material.dart';
import 'package:gambit/components/googletile.dart';
import 'package:gambit/components/my_button.dart';
import 'package:gambit/components/my_textfield.dart';
import 'package:gambit/components/appletile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gambit/components/start_logo.dart';
import 'package:gambit/pages/create_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailcontroller = TextEditingController();

  final passcontroller = TextEditingController();

  String? errorMessage;

  void signuserIn(BuildContext context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);

      Navigator.pop(context);
      // Wrong Email
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        // Show error message
        setState(() {
          errorMessage = 'User Not Found';
        });

        // Wrong Password
      } else if (e.code == 'wrong-password') {
        // Show error message
        setState(() {
          errorMessage = 'Wrong Password';
        });
      }
    }
  }

  void clearErrorMessage() {
    setState(() {
      errorMessage = null;
    });
  }

  // Login Page class
  @override
  Widget build(BuildContext context) {
    // Logo
    const logo = LogoBox(
      imagePath: 'assets/images/gambit2.png',
      logoHt: 180,
    );

    var buttonLogin = MyButton(
      onTap: () => signuserIn(context),
    );

    // Forgot password button
    const buttonForgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: null,
          child: Text(
            'Forgot Password',
            style: TextStyle(
              color: Color.fromARGB(255, 248, 203, 68),
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );

    // Seperator
    const seperator = Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromARGB(255, 248, 203, 68),
              height: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'OR',
              style: TextStyle(
                  color: Color.fromARGB(255, 248, 203, 68), fontSize: 16),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromARGB(255, 248, 203, 68),
            ),
          ),
        ],
      ),
    );

    // Alternate login view containing google and apple icons
    const alternateLoginview = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GoogleTile(imagePath: 'assets/images/google.png'),
        SizedBox(width: 55),
        SquareTile(imagePath: 'assets/images/apple.png'),
      ],
    );

    // Create an account
    var accountCreate = TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccount()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('New to Gambit?'),
            SizedBox(width: 4),
            Text('Create an account',
                style: TextStyle(
                  color: Color.fromARGB(255, 248, 203, 68),
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );

    // Scaffold for the login page
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: const AssetImage('assets/images/cinematic.jpg'),
              opacity: 0.5,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.95), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                // Widgets for the login page
                logo,

                MyTextField(
                    mycolor: const Color.fromARGB(237, 255, 179, 0),
                    controller: emailcontroller,
                    hintText: 'Email',
                    obscureText: false),

                const SizedBox(
                  height: 15,
                ),

                MyTextField(
                    mycolor: const Color.fromARGB(237, 255, 179, 0),
                    controller: passcontroller,
                    hintText: 'Password',
                    obscureText: true),

                buttonLogin,

                buttonForgotPassword,

                seperator,

                const SizedBox(
                  height: 15,
                ),

                alternateLoginview,

                accountCreate
              ],
            ),
          ),
        ),
      ),
    );
  }
}
