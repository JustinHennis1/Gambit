import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/coffee.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextTheme1('Settings'),
        ],
      ),
    );
  }
}
