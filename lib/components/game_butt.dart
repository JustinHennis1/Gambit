import 'package:flutter/material.dart';
import 'package:gambit/pages/chessboard.dart';

class GameButt extends StatelessWidget {
  const GameButt(this.choice, this.text1, {super.key});
  final int choice;
  final String text1;

  @override
  Widget build(context) {
    int choice = this.choice;
    return TextButton(
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 50)),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.95)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: () {
        if (choice == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        2,
                      )));
        }
        if (choice == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        3,
                      )));
        }
        if (choice == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        4,
                      )));
        }
        if (choice == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        5,
                      )));
        }
        if (choice == 5) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        6,
                      )));
        }
        if (choice == 6) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        7,
                      )));
        }
        if (choice == 7) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        8,
                      )));
        }
        if (choice == 8) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        9,
                      )));
        }
        if (choice == 9) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        10,
                      )));
        }
        if (choice == 10) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        11,
                      )));
        }
        if (choice == 11) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        12,
                      )));
        }
        if (choice == 12) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        13,
                      )));
        }
        if (choice == 13) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Gamestart(
                        13,
                      )));
        }
      },
      child: Text(
        text1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Young_Serif',
        ),
        textScaleFactor: 1,
      ),
    );
  }
}
