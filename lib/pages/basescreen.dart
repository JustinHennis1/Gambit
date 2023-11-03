import 'package:flutter/material.dart';
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
    if (version == 1) {
      return const MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Control1(),
        ),
      );
    }
    if (version == 2) {
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
      );
    }
  }
}
