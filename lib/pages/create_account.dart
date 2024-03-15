// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
//import 'package:gambit/components/appletile.dart';
import 'package:gambit/components/googletile.dart';
import 'package:gambit/components/my_textfield.dart';
import 'package:gambit/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:gambit/pages/auth_page.dart';
import 'package:gambit/pages/login_page.dart';
import 'package:gambit/services/adduser.dart';
import 'package:gambit/services/auth_service.dart';
import 'package:gambit/services/isusername.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String? errorMessage;

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  bool isStrongPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  Future<void> createAccount(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => _buildUsernameDialog(context),
    );
  }

  Widget _buildUsernameDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Username'),
      content: TextField(
        controller: usernameController,
        decoration: const InputDecoration(labelText: 'Enter your username'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);

            bool isUsernameAvailable =
                await isUserAvailable(usernameController.text);

            if (isUsernameAvailable) {
              await addNewUser(usernameController.text, emailController.text);

              await _createAccountWithEmail(context);

              //Navigator.pop(context);
            } else {
              setState(() {
                errorMessage =
                    'Username is already taken. Please choose another one.';
              });
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  _createAccountWithEmail(BuildContext context) async {
    try {
      //setValidationData('', '');
      if (!isValidEmail(emailController.text)) {
        _showErrorMessage('Invalid Email');
      } else if (!isStrongPassword(passwordController.text) ||
          !isValidEmail(emailController.text)) {
        _showErrorMessage(
            'Please include at least 1 uppercase, 1 lowercase, 1 number, and 1 special character');
      } else if (passwordController.text != confirmPasswordController.text) {
        _showErrorMessage('Passwords do not match');
      } else {
        clearErrorMessage();
        setValidationData(usernameController.text, emailController.text);

        // Use then to handle the successful account creation
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((userCredential) async {
          // Account creation successful, navigate to homepage
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      _showErrorMessage(e.message!);
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

  Future setValidationData(String username, String email) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
    sharedPreferences.setString('email', email);
  }

  var alternateLoginView = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GoogleTile(
        onTap: () => AuthService().signInWithGoogle(),
        imagePath: 'assets/images/google.png',
      ),
      //const SizedBox(width: 55),
      //const SquareTile(imagePath: 'assets/images/apple.png'),
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
            Text(
              'Sign In',
              style: TextStyle(
                color: Color.fromARGB(255, 248, 203, 68),
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    controller: emailController,
                    hintText: 'Enter Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    mycolor: Colors.amber,
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  FlutterPwValidator(
                    defaultColor: Colors.black87,
                    controller: passwordController,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    lowercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    width: 250,
                    height: 140,
                    onSuccess: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password is matched"),
                        ),
                      );
                    },
                    onFail: () {},
                  ),
                  MyTextField(
                    mycolor: Colors.amber,
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  buttonMakeAcc,
                  const SizedBox(height: 15),
                  alternateLoginView,
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
