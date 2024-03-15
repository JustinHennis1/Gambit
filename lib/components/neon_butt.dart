import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gambit/pages/choose_opp.dart';
import 'package:gambit/pages/games_page.dart';
import 'package:gambit/pages/match.dart';
import 'package:gambit/pages/puzzles.dart';
import 'package:gambit/services/deleteuser.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeonButt1 extends StatelessWidget {
  const NeonButt1(
    this.wording, {
    super.key,
  });
  final String wording;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80 * 4 / 3, // Adjust the height
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChooseOp()),
            );
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.amber.shade700.withOpacity(0.75),
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.black54,
          bottomRightShadowColor: Colors.amber.shade700.withOpacity(0.9),
          height: size.width * 0.175 * 4 / 3, // Adjust the height
          width: size.width * 0.3 * 2, // Adjust the width
          padding: const EdgeInsets.all(10), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              wording,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5, // Adjust the blur radius
                    color: Colors.white54,
                  ),
                ],
                letterSpacing: 2, // Adjust the letter spacing
                fontSize: 14 * 4 / 3, // Adjust the font size
                color: Colors.black,
                fontFamily: 'Young_Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NeonButt2 extends StatelessWidget {
  const NeonButt2(
    this.icon, {
    super.key,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80 * 4 / 3, // Adjust the height
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage()),
            );
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.black54,
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.white54,
          bottomRightShadowColor: Colors.black87,
          height: size.width * 0.175 * 4 / 3, // Adjust the height
          width: size.width * 0.3 * 4 / 3, // Adjust the width
          padding: const EdgeInsets.all(10), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: Colors.amber,
                size: 50,
              )),
        ),
      ),
    );
  }
}

class NeonButt4 extends StatelessWidget {
  const NeonButt4(
    this.icon, {
    super.key,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80 * 4 / 3, // Adjust the height
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Match()),
            );
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.black54,
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.white54,
          bottomRightShadowColor: Colors.black87,
          height: size.width * 0.175 * 4 / 3, // Adjust the height
          width: size.width * 0.3 * 4 / 3, // Adjust the width
          padding: const EdgeInsets.all(10), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: Colors.amber,
                size: 50,
              )),
        ),
      ),
    );
  }
}

class NeonButt5 extends StatelessWidget {
  const NeonButt5(
    this.wording, {
    super.key,
  });
  final String wording;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80 * 4 / 3, // Adjust the height
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzlesPage()),
            );
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.amber.shade700.withOpacity(0.75),
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.black54,
          bottomRightShadowColor: Colors.amber.shade700.withOpacity(0.9),
          height: size.width * 0.175 * 4 / 3, // Adjust the height
          width: size.width * 0.3 * 2, // Adjust the width
          padding: const EdgeInsets.all(10), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              wording,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5, // Adjust the blur radius
                    color: Colors.white54,
                  ),
                ],
                letterSpacing: 2, // Adjust the letter spacing
                fontSize: 14 * 4 / 3, // Adjust the font size
                color: Colors.black,
                fontFamily: 'Young_Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteAccount extends StatelessWidget {
  const DeleteAccount(
    this.username,
    this.wording, {
    super.key,
  });
  final String wording;
  final String username;

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
    Size size = MediaQuery.of(context).size;
    // void signUserOut() {
    //   logOff();
    //   FirebaseAuth.instance.signOut();
    // }

    return Container(
      height: 45 * 4 / 3, // Adjust the height
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            deleteUser(username);
            User? user = FirebaseAuth.instance.currentUser;
            user?.delete();
            Navigator.pop(context);
            //signUserOut();
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.red.shade700.withOpacity(0.75),
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.black54,
          bottomRightShadowColor: Colors.red.shade700.withOpacity(0.9),
          height: size.width * 0.175 * 4 / 3, // Adjust the height
          width: size.width * 0.3 * 2, // Adjust the width
          padding: const EdgeInsets.all(10), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              wording,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5, // Adjust the blur radius
                    color: Colors.white54,
                  ),
                ],
                letterSpacing: 2, // Adjust the letter spacing
                fontSize: 14 * 4 / 3, // Adjust the font size
                color: Colors.black,
                fontFamily: 'Young_Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
