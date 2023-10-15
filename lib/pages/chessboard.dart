//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class Gamestart extends StatefulWidget {
  const Gamestart({super.key});

  @override
  State<Gamestart> createState() => _GamestartState();
}

class _GamestartState extends State<Gamestart> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.orange,
                arrows: [
                  BoardArrow(
                    from: 'd2',
                    to: 'd4',
                    //color: Colors.red.withOpacity(0.5),
                  ),
                  BoardArrow(
                    from: 'e7',
                    to: 'e5',
                    color: Colors.red.withOpacity(0.7),
                  ),
                ],
                boardOrientation: PlayerColor.white,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Chess>(
              valueListenable: controller,
              builder: (context, game, _) {
                return Text(
                  controller.getSan().fold(
                        '',
                        (previousValue, element) =>
                            '$previousValue\n${element ?? ''}',
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
