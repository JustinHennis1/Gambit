import 'package:flutter/material.dart';
import 'package:gambit/chesslogic/game_board.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameBoard(),
    );
  }
}
