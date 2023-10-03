import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gambit/components/start_logo.dart';

const startAlign = Alignment.topLeft;
const endAlign = Alignment.bottomRight;

class StartScreenStyle extends StatelessWidget {
  const StartScreenStyle(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    var imageAnimate = const LogoBox(
      imagePath: 'assets/images/gambit2.png',
    );

    Widget myWidget = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: startAlign,
          end: endAlign,
          transform: const GradientRotation(19),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            imageAnimate
                .animate()
                .scaleXY(delay: 600.ms, duration: 1500.ms, end: 1.18)
                .elevation(
                    delay: 600.ms,
                    duration: 1000.ms,
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(50.4, 19.5)))
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
