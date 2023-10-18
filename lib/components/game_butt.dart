import 'package:flutter/material.dart';
import 'package:gambit/pages/chessboard.dart';

class GameButt extends StatelessWidget {
  const GameButt(this.text1, {super.key});

  final String text1;

  @override
  Widget build(context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll<Size>(Size(100, 50)),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Gamestart()));
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
