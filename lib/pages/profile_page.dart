import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          children: [
            Row(
              children: [
                SizedBox(child: TextTheme1('Profile')),
              ],
            ),
            Row(
              children: [
                SizedBox(child: TextTheme1('Your Stats')),
              ],
            ),
            Row(
              children: [
                SizedBox(child: TextTheme1('Rating: ')),
              ],
            ),
          ],
        ));
  }
}
