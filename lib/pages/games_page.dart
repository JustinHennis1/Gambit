import 'package:flutter/material.dart';
import 'package:gambit/components/game_butt.dart';
import 'package:gambit/pages/texttheme.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextTheme2('Choose Your \n Difficulty: '),
                    SizedBox(
                      height: constraints.maxHeight * 0.03,
                    ),
                    for (int i = 1; i <= 13; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GameButt(i, 'Level $i'),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
