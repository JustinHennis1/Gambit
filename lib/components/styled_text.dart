import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(context) {
    Widget myWidget = Text(
      text,
      style: GoogleFonts.martianMono(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              fontStyle: FontStyle.normal,
              color: Color.fromARGB(255, 0, 0, 0))),
    );
    return myWidget
        .animate()
        .rotate(duration: 1000.ms)
        .then()
        .slideY(end: -3)
        .shake(hz: 3);
  }
}
