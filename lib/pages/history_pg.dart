import 'package:flutter/material.dart';

import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/components/texttheme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: SizedBox(
            height: appBarHeight,
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
            image: const AssetImage('assets/images/history.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: const TextTheme1('History'),
      ),
    );
  }
}
