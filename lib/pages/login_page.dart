import 'package:flutter/material.dart';
import 'package:gambit/components/my_button.dart';
import 'package:gambit/components/my_textfield.dart';
import 'package:gambit/components/squaretile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

dynamic context = context;
//Text editing controllers
final emailcontroller = TextEditingController();
final passcontroller = TextEditingController();

void signuserIn(context) async {
  //show loading circle
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
    //Wrong Email
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // Show error message
      wrongEmailmessage(context);

      // Wrong Password
    } else if (e.code == 'wrong-password') {
      // Show error message
      wrongPasswordmessage(context);
    }
    Navigator.pop(context);
  }
}

//Wrong Email message
wrongEmailmessage(context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: AlertDialog(
          title: Text(
            'Incorrect Email',
            style: TextStyle(fontSize: 40),
          ),
        ),
      );
    },
  );
}

//Wrong Password message
wrongPasswordmessage(context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: AlertDialog(
          title: Text(
            'Incorrect Password',
            style: TextStyle(fontSize: 40),
          ),
        ),
      );
    },
  );
}

//Login Page class
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
//Logo
    final logo = Padding(
      padding: const EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: SizedBox(
            height: 160,
            child: Image.asset('assets/images/gambit1.png'),
          )),
    );

    var buttonLogin = MyButton(
      onTap: () => signuserIn(context),
    );

//Forgot password button
    const buttonForgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: null,
          child: Text(
            'Forgot Password',
            style: TextStyle(
                color: Color.fromARGB(210, 244, 15, 15), fontSize: 16),
          ),
        ),
        SizedBox(width: 10),
      ],
    );

//Seperator
    const seperator = Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.black,
              height: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

//Alternate login view containing google and apple icons
    const alternateLoginview = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SquareTile(imagePath: 'assets/images/google.png'),
        SizedBox(width: 55),
        SquareTile(imagePath: 'assets/images/apple.png'),
      ],
    );

//Create an account
    const accountCreate = Padding(
      padding: EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('New to Gambit?'),
          SizedBox(width: 4),
          Text('Create an account',
              style: TextStyle(
                color: Color.fromARGB(210, 244, 15, 15),
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );

// Scaffold for the login page
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //Colors for the gradient
              Color.fromARGB(255, 77, 50, 4),
              Color.fromARGB(255, 248, 203, 68),
            ],
            begin: Alignment.topLeft, //start of gradient
            end: Alignment.bottomRight, //end of gradient
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              //Widgets for the login page
              logo,

              MyTextField(
                  controller: emailcontroller,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(
                height: 15,
              ),

              MyTextField(
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
    ));
  }
}
