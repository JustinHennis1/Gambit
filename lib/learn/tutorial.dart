import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/cinematic.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: const TextTheme1('Tutorial'),
    );
  }
}
