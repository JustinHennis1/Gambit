import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:gambit/components/neon_butt.dart';

import 'package:gambit/components/texttheme.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseOp extends StatefulWidget {
  const ChooseOp({super.key});

  @override
  State<ChooseOp> createState() => _ChooseOpState();
}

class _ChooseOpState extends State<ChooseOp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    void getHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen(0)),
        (route) => false,
      );
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: SizedBox(
              height: appBarHeight,
              child: GestureDetector(
                  onDoubleTap: getHome,
                  child: Image.asset('assets/images/prodigy1.png'))),

          //title: const Text('Choose Your Opponent'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back when the back button is pressed
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: AnimatedBackground(
            behaviour: RacingLinesBehaviour(
                direction: LineDirection.Ttb, numLines: 20),
            vsync: this,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose ',
                      style: GoogleFonts.rubikGlitch(
                          fontSize: 30, color: Colors.amber),
                    ),
                    Text(
                      ' Your ',
                      style: GoogleFonts.rubikGlitch(fontSize: 30, color: Colors.amber),
                    ),
                    Text(
                      'Opponent',
                      style: GoogleFonts.rubikGlitch(fontSize: 30, color: Colors.amber),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NeonButt4(Icons.person),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.amber,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.amber, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NeonButt2(Icons.computer_rounded),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
