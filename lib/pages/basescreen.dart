import 'package:flutter/material.dart';
import 'package:gambit/components/routes.dart';
import 'package:gambit/controllers/control_1.dart';
import 'package:gambit/controllers/control_2.dart';
import 'package:gambit/controllers/tabcontrol.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
    this.version, {
    super.key,
  });
  final int version;

  @override
  Widget build(context) {
    return FutureBuilder(
      future: _precacheImages(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (version == 1) {
            return const MaterialApp(
              home: DefaultTabController(
                length: 2,
                child: Control1(),
              ),
            );
          } else if (version == 2) {
            return const MaterialApp(
              home: DefaultTabController(
                length: 4,
                child: Control2(),
              ),
            );
          } else {
            return const MaterialApp(
              home: DefaultTabController(
                length: 4,
                child: TabBarController(),
              ),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _precacheImages(context) async {
    await Future.wait([
      precacheImage(const AssetImage('assets/images/chessmove.jpg'), context),
      precacheImage(const AssetImage('assets/images/blur.jpg'), context),
      precacheImage(const AssetImage('assets/images/blur2.jpg'), context),
      precacheImage(const AssetImage('assets/images/gambit1.png'), context),
      precacheImage(const AssetImage('assets/images/gambit2.png'), context),
      precacheImage(const AssetImage('assets/images/cinematic.jpg'), context),
      precacheImage(const AssetImage('assets/images/back1.png'), context),
      precacheImage(const AssetImage('assets/images/back2.jpg'), context),
      precacheImage(const AssetImage('assets/images/lo.jpg'), context),
      // ... Add other images
    ]);
  }
}
