import 'package:flutter/material.dart';
import 'package:gambit/components/contain_image.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/texttheme.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    void getHome() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BaseScreen(0)));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: SizedBox(
            height: 90,
            child: GestureDetector(
                onDoubleTap: getHome,
                child: Image.asset('assets/images/prodigy1.png'))),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/social.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: const TextTheme1('Social'),
      ),
    );
  }
}
