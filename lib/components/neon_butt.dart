import 'package:flutter/material.dart';
import 'package:gambit/chesslogic/game_main.dart';
import 'package:gambit/pages/choose_opp.dart';
import 'package:gambit/pages/games_page.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

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
            child: Text(
              wording,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5, // Adjust the blur radius
                    color: Colors.black54,
                  ),
                ],
                letterSpacing: 2, // Adjust the letter spacing
                fontSize: 14 * 4 / 3, // Adjust the font size
                color: Colors.white,
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
