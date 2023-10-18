import 'package:flutter/material.dart';
import 'package:gambit/components/game_butt.dart';
import 'package:gambit/pages/texttheme.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/cinematic.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextTheme2('Choose Your Game: '),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GameButt('5 | 0'),
              GameButt('5 | 5'),
              GameButt('10 | 0'),
              GameButt('10 | 5'),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 248, 203, 68),
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GameButt('15 | 0'),
              GameButt('15 | 5'),
              GameButt('30 | 0'),
              GameButt('30 | 5'),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 248, 203, 68),
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameButt('1 hr'),
              VerticalDivider(
                thickness: 0.5,
                color: Color.fromARGB(255, 248, 203, 68),
                width: 50,
              ),
              GameButt('1 day'),
            ],
          ),
        ],
      ),
    );
  }
}
