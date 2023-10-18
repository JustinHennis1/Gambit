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
          color: Colors.amber,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/back3.jpg'),
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
