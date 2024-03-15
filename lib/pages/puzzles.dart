import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:gambit/flutter_chess_board.dart';
//import 'package:gambit/pages/stockfish_fen.dart';
import 'package:gambit/src/chess_board.dart';
import 'dart:math';

class ChessPuzzle {
  final String fen;
  final List<String> expectedMoves;

  ChessPuzzle({
    required this.fen,
    required this.expectedMoves,
  });
}

class PuzzlesPage extends StatefulWidget {
  const PuzzlesPage({super.key});

  @override
  State<PuzzlesPage> createState() => _PuzzlesPageState();
}

class _PuzzlesPageState extends State<PuzzlesPage> {
  List<BoardArrow> arrows = [];
  //late Process process;
  PlayerColor pcolor = PlayerColor.white;
  bool enableusermoves = true;
  late List<ChessPuzzle> puzzles;
  late ChessPuzzle currentPuzzle;
  int currentPuzzleIndex = 0;
  int currentMoveIndex = 0;
  int index = 0;
  bool? isCorrectMove;
  String firstmove = '';
  List<String> checkMoves = [];
  ChessBoardController controller = ChessBoardController();
  GlobalKey<State<ChessBoard>> chessBoardKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    loadPuzzles();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    await loadPuzzles();
    // Pass initialfen to handleMove
    handleMove(firstmove, controller);
    setState(() {
      index++;
    });
  }

  void handleMove(String bestMove, ChessBoardController controller) async {
    setState(() {
      enableusermoves = false;
    });

    // Check if promotion
    if (bestMove.endsWith('q') ||
        bestMove.endsWith('r') ||
        bestMove.endsWith('b') ||
        bestMove.endsWith('n')) {
      // Extract promotion piece
      String promoPiece = bestMove.substring(4, 5);
      setState(() {
        enableusermoves = true;
      });
      // Make promotion move
      controller.makeMoveWithPromotion(
        from: bestMove.substring(0, 2),
        to: bestMove.substring(2, 4),
        pieceToPromoteTo: promoPiece,
      );
    } else {
      setState(() {
        enableusermoves = true;
      });
      // Normal move
      controller.makeMove(
        from: bestMove.substring(0, 2),
        to: bestMove.substring(2, 4),
      );
    }
    // Update arrows to show the move

    updateArrows(
      bestMove.substring(0, 2),
      bestMove.substring(2, 4),
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

  // Function to show the game over dialog
  Future<void> showPuzzleSolvedDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            color: Colors.green.shade800,
            margin: const EdgeInsets.all(8),
            child: const SizedBox(
              width: 250, // Adjust the width as needed
              height: 250, // Adjust the height as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.check_box_sharp,
                    color: Colors.green,
                    size: 250,
                  ),
                  Center(
                    child: Text(
                      'Puzzle Solved',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> loadPuzzles() async {
    String puzzleData = await DefaultAssetBundle.of(context)
        .loadString('lib/puzzle_maker/puzzleholder.txt');
    List<String> puzzleLines = puzzleData.split('\n');

    setState(() {
      puzzles = puzzleLines.map((puzzle) {
        List<String> puzzleParts = puzzle.split(' ');
        String fen = puzzleParts[0];
        List<String> expectedMoves = puzzleParts.sublist(1);

        // Extract the first 5 non-null characters from the expectedMoves sublist
        String movesToAddToFen = expectedMoves.join(' ');
        if (movesToAddToFen.length > 5) {
          movesToAddToFen = movesToAddToFen.substring(0, 10);
        }
        String movesString = expectedMoves.join(' ');
        if (movesString.length > 5) {
          movesString = movesString.substring(
            11,
          );
        }
        expectedMoves = movesString.split(' ').toList();
        for (int i = 0; i <= 9; i++) {
          if (expectedMoves[0] == i.toString()) {
            expectedMoves[0] = '';
          }
        }

        //print('move string $movesString');

        // Add the moves to the end of the fen string
        fen = '$fen $movesToAddToFen';
        fen = fen.trim();

        return ChessPuzzle(fen: fen, expectedMoves: expectedMoves);
      }).toList();
      Random random = Random();
      int randomIndex = random.nextInt(puzzles.length);
      currentPuzzleIndex = randomIndex;

      currentPuzzle = puzzles[currentPuzzleIndex];
      controller.loadFen(currentPuzzle.fen);
      firstmove = currentPuzzle.expectedMoves[0].trim();
      print('firstmove = $firstmove');
      print('This is current puzzle fen ${currentPuzzle.fen}');
      print(
          'This is current puzzle expected moves ${currentPuzzle.expectedMoves}');
    });
  }

  void goToNextPuzzle() {
    if (currentPuzzleIndex < puzzles.length - 1) {
      setState(() {
        currentPuzzleIndex++;
        currentPuzzle = puzzles[currentPuzzleIndex];
        currentMoveIndex = 0;
        checkMoves = [];
        isCorrectMove = null;
        enableusermoves = true;
        index = 1;
        // Assign a new key to reset Chessboard state
        chessBoardKey = GlobalKey<State<ChessBoard>>();
      });
      print('This is the currentPuzzle fen: ${currentPuzzle.fen}');
      print('Expected Moves: ${currentPuzzle.expectedMoves}');
      var tempmove = currentPuzzle.expectedMoves[0].trim();

      controller.loadFen(currentPuzzle.fen);
      controller.makeMove(
          from: tempmove.substring(0, 2), to: tempmove.substring(2, 4));
      updateArrows(tempmove.substring(0, 2), tempmove.substring(2, 4));
    }
  }

  void goToPreviousPuzzle() {
    if (currentPuzzleIndex > 0) {
      setState(() {
        currentPuzzleIndex--;
        currentPuzzle = puzzles[currentPuzzleIndex];
        currentMoveIndex = 0;
        checkMoves = [];
        isCorrectMove = null;
        enableusermoves = true;
        index = 1;
        // Assign a new key to reset Chessboard state
        chessBoardKey = GlobalKey<State<ChessBoard>>();
        controller.makeMove(
            from: currentPuzzle.expectedMoves[0].substring(0, 2),
            to: currentPuzzle.expectedMoves[0].substring(2, 4));
      });
      print('This is the currentPuzzle fen: ${currentPuzzle.fen}');
      print('Expected Moves: ${currentPuzzle.expectedMoves}');
      controller.loadFen(currentPuzzle.fen);
      var tempmove = currentPuzzle.expectedMoves[0].trim();
      controller.makeMove(
          from: tempmove.substring(0, 2), to: tempmove.substring(2, 4));
      updateArrows(tempmove.substring(0, 2), tempmove.substring(2, 4));
    }
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: const Text('Chess Puzzles'),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.85),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        if (checkMoves.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isCorrectMove == true
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isCorrectMove == true
                                  ? "Correct Move"
                                  : "Wrong Move",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Column(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 5),
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
                                    '8',
                                    '7',
                                    '6',
                                    '5',
                                    '4',
                                    '3',
                                    '2',
                                    '1',
                                  ])
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9, horizontal: 5),
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
                            Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                ChessBoard(
                                  key: chessBoardKey,
                                  size: 350,
                                  enableUserMoves: enableusermoves,
                                  onMove: (move) {
                                    print('index = $index');
                                    var expectedMove = currentPuzzle
                                        .expectedMoves[index]
                                        .trim();

                                    final userMove = move.trim();
                                    updateArrows(move.substring(0, 2),
                                        move.substring(2, 4));
                                    if (expectedMove == userMove &&
                                        expectedMove ==
                                            currentPuzzle.expectedMoves.last
                                                .trim()) {
                                      showPuzzleSolvedDialog();
                                      setState(() {
                                        enableusermoves = false;
                                      });
                                    }
                                    if (expectedMove == userMove) {
                                      setState(() {
                                        isCorrectMove = true;
                                        index++;
                                      });

                                      print(
                                          'The move is : $isCorrectMove, $expectedMove and $userMove');
                                    } else {
                                      controller.game.undo_move();
                                      //print('tempexpected = $tempexpected');
                                      setState(() {
                                        isCorrectMove = false;
                                      });

                                      print(
                                          'The move is : $isCorrectMove, $expectedMove and $userMove');
                                    }

                                    print(index % 2);
                                    if (index % 2 == 0 &&
                                        enableusermoves == true) {
                                      expectedMove = currentPuzzle
                                          .expectedMoves[index]
                                          .trim();
                                      handleMove(expectedMove, controller);
                                      index++;
                                    }
                                  },
                                  controller: controller,
                                  boardColor: BoardColor.brown,
                                  arrows: arrows,
                                  boardOrientation: pcolor,
                                  onGetMovesList: (movesList) {
                                    var subMoves =
                                        movesList.sublist(currentMoveIndex);

                                    for (var move in subMoves) {
                                      if (!checkMoves.contains(move)) {
                                        checkMoves.add(move);
                                      }
                                      currentMoveIndex++;

                                      // Ensure that currentMoveIndex stays within the bounds of the expected moves list
                                      if (currentMoveIndex >=
                                          currentPuzzle.expectedMoves.length) {
                                        currentMoveIndex =
                                            currentPuzzle.expectedMoves.length -
                                                1;
                                        break; // Exit the loop if the index is out of bounds
                                      }

                                      // print(
                                      //     'current move index = $currentMoveIndex');
                                    }
                                  },
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.amber),
                  onPressed: goToPreviousPuzzle,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.amber),
                  onPressed: goToNextPuzzle,
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Previous Puzzle",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Next Puzzle",
                  style: TextStyle(color: Colors.white),
                ),
              ],
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
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.transparent,
                                  fontFamily: "Times New Roman"));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PuzzlesPage(),
  ));
}
