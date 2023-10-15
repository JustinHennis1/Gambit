import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gambit/components/start_logo.dart';

const startAlign = Alignment.topLeft;
const endAlign = Alignment.bottomRight;

class StartScreenStyle extends StatelessWidget {
  const StartScreenStyle({super.key});

  

  @override
  Widget build(context) {
    var imageAnimate = const LogoBox(
      imagePath: 'assets/images/gambit2.png',
      logoHt: 250,
    );

    Widget myWidget = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/cinematic.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95), BlendMode.dstATop),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            imageAnimate
                .animate()
                .scaleXY(delay: 600.ms, duration: 1500.ms, end: 1.15)
                .then()
                .fadeIn(begin: 0.1, duration: 2000.ms),
            const SizedBox(height: 100),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );

    return myWidget.animate().then().shimmer(delay: 1000.ms, duration: 3000.ms);
  }
}
