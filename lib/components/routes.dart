import 'package:flutter/material.dart';
import 'package:gambit/pages/choose_opp.dart';
import 'package:gambit/pages/play_as_wht.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case '/Gamestart':
        return MaterialPageRoute(
          builder: (_) => const Gamestart(1, 100),
        );
      case '/ChooseOp':
        return MaterialPageRoute(
          builder: (_) => const ChooseOp(),
        );

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  });
}
