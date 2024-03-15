import 'package:flutter/material.dart';
import 'package:gambit/components/googletile.dart';
import 'package:gambit/components/my_button.dart';
import 'package:gambit/components/my_textfield.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gambit/components/start_logo.dart';
import 'package:gambit/pages/auth_page.dart';
import 'package:gambit/pages/create_account.dart';
import 'package:gambit/services/auth_service.dart';
import 'package:gambit/services/getrating.dart';
import 'package:gambit/services/getusername.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      var tempuser = await getUsernameByEmail(emailcontroller.text);
      if (tempuser != null) {
        setValidationData(tempuser, emailcontroller.text);
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      // Wrong Email
    } on FirebaseAuthException catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      switch (e.code) {
        case 'user-not-found':
          _showErrorMessage('User not found. Please check your email.');
          break;
        case 'wrong-password':
          _showErrorMessage('Wrong password. Please try again.');
          break;
        case 'invalid-email':
          _showErrorMessage(
              'Invalid email address. Please enter a valid email.');
          break;
        case 'user-disabled':
          _showErrorMessage(
              'Account has been disabled. Please contact support.');
          break;
        case 'too-many-requests':
          _showErrorMessage('Too many sign-in attempts. Try again later.');
          break;
        default:
          // Handle other errors or log the unknown error

          _showErrorMessage('An unknown error occurred. Please try again.');
      }
    }
  }

  void _showErrorMessage(String message) {
    // Use a Future to update the state after the build phase
    Future.delayed(Duration.zero, () {
      setState(() {
        errorMessage = message;
      });
    });
  }

  void clearErrorMessage() {
    setState(() {
      errorMessage = null;
    });
  }

  Future setValidationData(String username, String email) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
    sharedPreferences.setString('email', email);

    var userRating1 = await isRatingAvailable(username);
    sharedPreferences.setInt('rating', userRating1);
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
    var alternateLoginview = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GoogleTile(
            onTap: () async {
              await AuthService().signInWithGoogle();
            },
            imagePath: 'assets/images/google.png'),
        //const SizedBox(width: 55),
        //const SquareTile(imagePath: 'assets/images/apple.png'),
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

                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),

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
