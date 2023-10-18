//import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:gambit/pages/stockfish_fen.dart';

class Gamestart extends StatefulWidget {
  const Gamestart({Key? key}) : super(key: key);

  @override
  State<Gamestart> createState() => _GamestartState();
}

class _GamestartState extends State<Gamestart> {
  ChessBoardController controller = ChessBoardController();
  List<BoardArrow> arrows = [];
  late Process process;

  void handleMove(String fen, ChessBoardController controller) async {
    String? bestMove = await getBestMove(fen);
    //controller.makeMoveWithPromotion(from: from, to: to, pieceToPromoteTo: pieceToPromoteTo)
    // Handle the best move and update the board
    controller.makeMove(
      from: bestMove.substring(0, 2),
      to: bestMove.substring(2, 4),
    );

    // Update arrows to show the move
    updateArrows(
      bestMove.substring(0, 2),
      bestMove.substring(2, 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ChessBoard(
                  onMove: () {
                    if (controller.isCheckMate()) {
                      // Show winner message
                      showGameOverDialog(
                          'Congratulations! You checkmated the computer.');
                    } else {
                      // Show try again message
                      showGameOverDialog(
                          'Game Over! You were checkmated by the computer.');
                    }
                    handleMove(controller.getFen(), controller);
                  },
                  controller: controller,
                  boardColor: BoardColor.brown,
                  arrows: arrows,
                  boardOrientation: PlayerColor.white,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ValueListenableBuilder<Chess>(
                    valueListenable: controller,
                    builder: (context, game, _) {
                      return Text(
                          controller.getSan().fold(
                                '',
                                (previousValue, element) =>
                                    '$previousValue\n${element ?? ''}',
                              ),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function to show the game over dialog
  Future<void> showGameOverDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and reset the game
                Navigator.of(context).pop();
                controller.game.reset();
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  // Function to update arrows based on the last move played
  void updateArrows(String from, String to) {
    setState(() {
      arrows = [
        BoardArrow(
          from: from,
          to: to,
          color: Colors.green.withOpacity(0.5),
        ),
      ];
    });
  }

  // Function to handle the best move received from Stockfish
  void handleBestMove(String bestMove) {
    // Make the move on the chess board
    controller.makeMove(
      from: bestMove.substring(0, 2),
      to: bestMove.substring(2, 4),
    );

    // Update arrows to show the move
    updateArrows(
      bestMove.substring(0, 2),
      bestMove.substring(2, 4),
    );
  }
}
