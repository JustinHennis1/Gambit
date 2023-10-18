import 'package:flutter/material.dart';
import 'package:gambit/components/appletile.dart';
import 'package:gambit/components/googletile.dart';
import 'package:gambit/components/my_textfield.dart';
import 'package:gambit/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gambit/pages/auth_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:gambit/pages/login_page.dart';
import 'package:gambit/services/auth_service.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final cpasscontroller = TextEditingController();
  String? errorMessage;

  bool isValidEmail(String email) {
    if (EmailValidator.validate(email)) {
      return true;
    }
    return false;
  }

  bool isStrongPassword(String password) {
    // Define a regex pattern for strong password requirements
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
    );

    // Check if the password matches the pattern
    return passwordRegex.hasMatch(password);
  }

  void createAccount(BuildContext context) async {
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
      if (!isValidEmail(emailcontroller.text)) {
        // Show error message
        setState(() {
          errorMessage = 'Invalid Email';
        });
      } else if (!isStrongPassword(passcontroller.text) ||
          !isValidEmail(emailcontroller.text)) {
        // Show error message
        setState(() {
          errorMessage =
              'Please include at least 1 uppercase, 1 lowercase, 1 number, and 1 special character';
        });
      } else if (passcontroller.text != cpasscontroller.text) {
        // Show error message
        setState(() {
          errorMessage = 'Passwords do not match';
        });
      } else if (passcontroller.text != cpasscontroller.text ||
          !isValidEmail(emailcontroller.text) ||
          !isStrongPassword(passcontroller.text)) {
        // Show error message
        setState(() {
          errorMessage = 'Incorrect Email or Password';
        });
      } else {
        // Clear any existing error message
        clearErrorMessage();

        // If there are no errors, create the user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passcontroller.text);

        // Navigate to the AuthPage
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      setState(() {
        errorMessage = e.message;
      });
    } finally {
      // Hide loading circle
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  // Alternate login view containing google and apple icons
  var alternateLoginview = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GoogleTile(
          onTap: () => AuthService().signInWithGoogle(),
          imagePath: 'assets/images/google.png'),
      const SizedBox(width: 55),
      const SquareTile(imagePath: 'assets/images/apple.png'),
    ],
  );

  void clearErrorMessage() {
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonMakeAcc = MyButton(
      onTap: () {
        clearErrorMessage();
        createAccount(context);
      },
    );

    // Already have an account
    var iHaveAccount = TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Have an Account?'),
            SizedBox(width: 4),
            Text('Sign In',
                style: TextStyle(
                  color: Color.fromARGB(255, 248, 203, 68),
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: const AssetImage('assets/images/cinematic.jpg'),
                  opacity: 0.5,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.95),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  const SizedBox(height: 20),
                  MyTextField(
                    mycolor: Colors.amber,
                    controller: emailcontroller,
                    hintText: 'Enter Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    mycolor: Colors.amber,
                    controller: passcontroller,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  FlutterPwValidator(
                    defaultColor: Colors.black87,
                    controller: passcontroller,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    lowercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    width: 250,
                    height: 140,
                    onSuccess: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password is matched")),
                      );
                    },
                    onFail: () {},
                  ),
                  MyTextField(
                    mycolor: Colors.amber,
                    controller: cpasscontroller,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  buttonMakeAcc,
                  const SizedBox(height: 15),
                  alternateLoginview,
                  iHaveAccount,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
