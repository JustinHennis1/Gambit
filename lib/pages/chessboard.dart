//import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:gambit/pages/stockfish_fen.dart';
//import 'package:gambit/pages/stockfish_fen.dart';

class Gamestart extends StatefulWidget {
  const Gamestart(this.depth, {super.key});
  final int depth;
  @override
  State<Gamestart> createState() => _GamestartState();
}

class _GamestartState extends State<Gamestart> {
  ChessBoardController controller = ChessBoardController();

  List<BoardArrow> arrows = [];
  late Process process;
  PlayerColor pcolor = PlayerColor.white;
  bool enableusermoves = true;
  void handleMove(String fen, ChessBoardController controller) async {
    setState(() {
      enableusermoves = false;
    });
    String? bestMove = await getBestMove(
      fen,
      widget.depth,
    );
    setState(() {
      enableusermoves = true;
    });
    // Handle the best move and update the board
    controller.makeMove(
      from: bestMove.substring(0, 2),
      to: bestMove.substring(2, 4),
    );
    if (controller.isCheckMate()) {
      showGameOverDialog('Checkmate, You Lose. \n Try again next time');
    }
    //print(controller.isCheckMate());
    // Update arrows to show the move
    updateArrows(
      bestMove.substring(0, 2),
      bestMove.substring(2, 4),
    );
  }

  // Variable to store the currently selected square

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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 5),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/blur.jpg'),
                            fit: BoxFit.fill),
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                ),
                const Text(
                  "Computer Boss",
                  style: TextStyle(
                      color: Colors.redAccent,
                      backgroundColor: Colors.black,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          if (pcolor == PlayerColor.black)
                            for (var number in [
                              '',
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              ''
                            ])
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child: Text(
                                  number,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                          else
                            for (var number in [
                              '',
                              '8',
                              '7',
                              '6',
                              '5',
                              '4',
                              '3',
                              '2',
                              '1',
                              ''
                            ])
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 11),
                                  child: Text(
                                    number,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ChessBoard(
                          size: 350,
                          enableUserMoves: enableusermoves,
                          onMove: () {
                            if (controller.getPossibleMoves() == [] &&
                                controller.isStaleMate() == false) {
                              showGameOverDialog('Checkmate, You Lose');
                            } else if (controller.isInCheck() == true) {
                              // Show check message
                              showCheckDialog('Someone is in check, Yikes');
                            } else if (controller.isCheckMate() == true) {
                              // Show winner message
                              showGameOverDialog(
                                  'Checkmate, You Win. Chicken Dinner! Chicken Dinner! \n Looks Like We Have A Master In Our Midst');
                            } else if (controller.isStaleMate() == true) {
                              // Show try again message
                              showGameOverDialog('Draw');
                            }
                            handleMove(
                              controller.getFen(),
                              controller,
                            );
                          },
                          controller: controller,
                          boardColor: BoardColor.brown,
                          arrows: arrows,
                          boardOrientation: pcolor,
                        ),
                        Row(
                          children: [
                            // Conditionally display board letters
                            if (pcolor == PlayerColor.white)
                              for (var letter in [
                                'a',
                                'b',
                                'c',
                                'd',
                                'e',
                                'f',
                                'g',
                                'h'
                              ])
                                Center(
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 32,
                                    ),
                                  ),
                                )
                            else
                              for (var letter in [
                                'h',
                                'g',
                                'f',
                                'e',
                                'd',
                                'c',
                                'b',
                                'a'
                              ])
                                Center(
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 32,
                                    ),
                                  ),
                                ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: 150,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      Colors.brown.withOpacity(0.70),
                                  fontFamily: "Times New Roman"));
                        },
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      TextButton(
                          onPressed: (null),
                          child: Text(
                            "press me",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      TextButton(
                          onPressed: (null),
                          child: Text(
                            "press me",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ],
                  )
                ],
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

//If check and not checkmate
  Future<void> showCheckDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and reset the game
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
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
