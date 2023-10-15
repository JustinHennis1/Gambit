import 'package:flutter/material.dart';
import 'package:gambit/pages/tabcontrol.dart';
import 'package:gambit/pages/texttheme.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: TabBarController(),
      ),
    );
  }
}
