import 'dart:math';

import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:chess/chess.dart' hide State;
import 'board_arrow.dart';
import 'chess_board_controller.dart';
import 'constants.dart';

class ChessBoard extends StatefulWidget {
  /// An instance of [ChessBoardController] which holds the game and allows
  /// manipulating the board programmatically.
  final ChessBoardController controller;

  /// Size of chessboard
  final double? size;

  /// A boolean which checks if the user should be allowed to make moves
  final bool enableUserMoves;

  /// The color type of the board
  final BoardColor boardColor;

  final PlayerColor boardOrientation;

  final Function(String move)? onMove;

  final List<BoardArrow> arrows;
  final Function(List<String> movesList)? onGetMovesList; // Callback function

  const ChessBoard({
    Key? key, // Specify the key parameter explicitly
    required this.controller,
    this.size,
    this.enableUserMoves = true,
    this.boardColor = BoardColor.brown,
    this.boardOrientation = PlayerColor.white,
    this.onMove,
    this.arrows = const [],
    this.onGetMovesList, // Provide the callback function as a parameter
  }) : super(key: key); // Pass the key to the superclass constructor

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  var selectedSquare = '';
  var destinationSquare = '';
  var possibleMoves = [];
  List<String> moveList = [];

  List<String> getMoveList() {
    return moveList;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Chess>(
      valueListenable: widget.controller,
      builder: (context, game, _) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: _getBoardImage(widget.boardColor),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    var row = index ~/ 8;
                    var column = index % 8;
                    var boardRank = widget.boardOrientation == PlayerColor.black
                        ? '${row + 1}'
                        : '${(7 - row) + 1}';
                    var boardFile = widget.boardOrientation == PlayerColor.white
                        ? files[column]
                        : files[7 - column];

                    var squareName = '$boardFile$boardRank';
                    //var pieceOnSquare = game.get(squareName);
                    var isSelected = selectedSquare == squareName;

                    var piece = BoardPiece(
                      squareName: squareName,
                      game: game,
                    );
                    List<dynamic> getPossibleMoves(Chess game, String square) {
                      List<dynamic> allMoves = game.moves({'verbose': true});
                      List<dynamic> selectedPieceMoves = [];

                      for (var move in allMoves) {
                        if (move['from'] == square) {
                          selectedPieceMoves.add(move['to']);
                        }
                      }
                      //print(selectedPieceMoves);
                      return selectedPieceMoves;
                    }

                    var squareWidget = GestureDetector(
                      onTap: () async {
                        if (widget.enableUserMoves) {
                          if (selectedSquare != '' &&
                              selectedSquare != squareName) {
                            destinationSquare = squareName;
                            if (possibleMoves.contains(destinationSquare)) {
                              // makeMove
                              Piece? control = game.get(selectedSquare);
                              if (control?.type == PieceType.PAWN &&
                                      control?.color == Color.WHITE &&
                                      destinationSquare[1] == '8' ||
                                  (control?.type == PieceType.PAWN &&
                                      control?.color == Color.BLACK &&
                                      destinationSquare[1] == '1')) {
                                var val = await _promotionDialog(context);

                                if (val != null) {
                                  widget.controller.makeMoveWithPromotion(
                                    from: selectedSquare,
                                    to: destinationSquare,
                                    pieceToPromoteTo: val,
                                  );
                                } else {
                                  return;
                                }
                              }

                              widget.controller.makeMove(
                                  from: selectedSquare, to: destinationSquare);
                              //print('$selectedSquare$destinationSquare');
                              var move = '$selectedSquare$destinationSquare';
                              moveList.add(move);
                              widget.onMove?.call(move);
                              widget.onGetMovesList?.call(moveList);
                              setState(() {
                                selectedSquare = '';
                                destinationSquare = '';
                                possibleMoves
                                    .clear(); // Clear possible moves after move
                              });
                            } else {
                              setState(() {
                                selectedSquare = '';
                                possibleMoves
                                    .clear(); // Clear possible moves if move is not valid
                              });
                            }
                          } else if (selectedSquare != '' &&
                              selectedSquare == squareName) {
                            setState(() {
                              selectedSquare = '';
                              possibleMoves
                                  .clear(); // Clear possible moves if the same square is selected again
                            });
                          } else {
                            setState(() {
                              selectedSquare = squareName;
                              possibleMoves =
                                  getPossibleMoves(game, squareName);
                            });
                            //print(selectedSquare);
                          }
                        }
                      },
                      child: Container(
                        color: possibleMoves.contains(squareName)
                            ? Colors.red.withOpacity(0.65)
                            : isSelected
                                ? Colors.blue.withOpacity(0.65)
                                : null,
                        child: piece, // Your existing piece widget
                      ),
                    );

                    // var draggable = game.get(squareName) != null
                    //     ? Draggable<PieceMoveData>(
                    //         feedback: piece,
                    //         childWhenDragging: const SizedBox(),
                    //         data: PieceMoveData(
                    //           squareName: squareName,
                    //           pieceType:
                    //               pieceOnSquare?.type.toUpperCase() ?? 'P',
                    //           pieceColor: pieceOnSquare?.color ?? Color.WHITE,
                    //         ),
                    //         child: squareWidget,
                    //       )
                    //     : Container();

                    //   var dragTarget =
                    //       DragTarget<PieceMoveData>(builder: (context, list, _) {
                    //     return draggable;
                    //   }, onWillAccept: (pieceMoveData) {
                    //     return widget.enableUserMoves ? true : false;
                    //   }, onAccept: (PieceMoveData pieceMoveData) async {
                    //     // A way to check if move occurred.
                    //     Color moveColor = game.turn;

                    //     if (pieceMoveData.pieceType == "P" &&
                    //         ((pieceMoveData.squareName[1] == "7" &&
                    //                 squareName[1] == "8" &&
                    //                 pieceMoveData.pieceColor == Color.WHITE) ||
                    //             (pieceMoveData.squareName[1] == "2" &&
                    //                 squareName[1] == "1" &&
                    //                 pieceMoveData.pieceColor == Color.BLACK))) {
                    // var val = await _promotionDialog(context);

                    // if (val != null) {
                    //   widget.controller.makeMoveWithPromotion(
                    //     from: pieceMoveData.squareName,
                    //     to: squareName,
                    //     pieceToPromoteTo: val,
                    //   );
                    // } else {
                    //   return;
                    // }
                    //     } else {
                    //       widget.controller.makeMove(
                    //         from: pieceMoveData.squareName,
                    //         to: squareName,
                    //       );
                    //     }
                    //     if (game.turn != moveColor) {
                    //       widget.onMove?.call();
                    //     }
                    //   });

                    //   return dragTarget;
                    // },
                    return squareWidget;
                  },
                  itemCount: 64,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
              if (widget.arrows.isNotEmpty)
                IgnorePointer(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CustomPaint(
                      painter:
                          _ArrowPainter(widget.arrows, widget.boardOrientation),
                      child: Container(),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Returns the board image
  Image _getBoardImage(BoardColor color) {
    switch (color) {
      case BoardColor.brown:
        return Image.asset(
          "assets/images/brown_board.png",
          fit: BoxFit.cover,
        );
      case BoardColor.darkBrown:
        return Image.asset(
          "assets/images/dark_brown_board.png",
          fit: BoxFit.cover,
        );
      case BoardColor.green:
        return Image.asset(
          "assets/images/green_board.png",
          fit: BoxFit.cover,
        );
      case BoardColor.orange:
        return Image.asset(
          "assets/images/orange_board.png",
          fit: BoxFit.cover,
        );
    }
  }

  /// Show dialog when pawn reaches last square
  Future<String?> _promotionDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose promotion'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: WhiteQueen(),
                onTap: () {
                  Navigator.of(context).pop("q");
                },
              ),
              InkWell(
                child: WhiteRook(),
                onTap: () {
                  Navigator.of(context).pop("r");
                },
              ),
              InkWell(
                child: WhiteBishop(),
                onTap: () {
                  Navigator.of(context).pop("b");
                },
              ),
              InkWell(
                child: WhiteKnight(),
                onTap: () {
                  Navigator.of(context).pop("n");
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      return value;
    });
  }
}

class BoardPiece extends StatelessWidget {
  final String squareName;
  final Chess game;

  const BoardPiece({
    super.key,
    required this.squareName,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    late Widget imageToDisplay;
    var square = game.get(squareName);

    if (game.get(squareName) == null) {
      return Container();
    }

    String piece = (square?.color == Color.WHITE ? 'W' : 'B') +
        (square?.type.toUpperCase() ?? 'P');

    switch (piece) {
      case "WP":
        imageToDisplay = WhitePawn();
        break;
      case "WR":
        imageToDisplay = WhiteRook();
        break;
      case "WN":
        imageToDisplay = WhiteKnight();
        break;
      case "WB":
        imageToDisplay = WhiteBishop();
        break;
      case "WQ":
        imageToDisplay = WhiteQueen();
        break;
      case "WK":
        imageToDisplay = WhiteKing();
        break;
      case "BP":
        imageToDisplay = BlackPawn();
        break;
      case "BR":
        imageToDisplay = BlackRook();
        break;
      case "BN":
        imageToDisplay = BlackKnight();
        break;
      case "BB":
        imageToDisplay = BlackBishop();
        break;
      case "BQ":
        imageToDisplay = BlackQueen();
        break;
      case "BK":
        imageToDisplay = BlackKing();
        break;
      default:
        imageToDisplay = WhitePawn();
    }

    return imageToDisplay;
  }
}

class PieceMoveData {
  final String squareName;
  final String pieceType;
  final Color pieceColor;

  PieceMoveData({
    required this.squareName,
    required this.pieceType,
    required this.pieceColor,
  });
}

class _ArrowPainter extends CustomPainter {
  List<BoardArrow> arrows;
  PlayerColor boardOrientation;

  _ArrowPainter(this.arrows, this.boardOrientation);

  @override
  void paint(Canvas canvas, Size size) {
    var blockSize = size.width / 8;
    var halfBlockSize = size.width / 16;

    for (var arrow in arrows) {
      var startFile = files.indexOf(arrow.from[0]);
      var startRank = int.parse(arrow.from[1]) - 1;
      var endFile = files.indexOf(arrow.to[0]);
      var endRank = int.parse(arrow.to[1]) - 1;

      int effectiveRowStart = 0;
      int effectiveColumnStart = 0;
      int effectiveRowEnd = 0;
      int effectiveColumnEnd = 0;

      if (boardOrientation == PlayerColor.black) {
        effectiveColumnStart = 7 - startFile;
        effectiveColumnEnd = 7 - endFile;
        effectiveRowStart = startRank;
        effectiveRowEnd = endRank;
      } else {
        effectiveColumnStart = startFile;
        effectiveColumnEnd = endFile;
        effectiveRowStart = 7 - startRank;
        effectiveRowEnd = 7 - endRank;
      }

      var startOffset = Offset(
          ((effectiveColumnStart + 1) * blockSize) - halfBlockSize,
          ((effectiveRowStart + 1) * blockSize) - halfBlockSize);
      var endOffset = Offset(
          ((effectiveColumnEnd + 1) * blockSize) - halfBlockSize,
          ((effectiveRowEnd + 1) * blockSize) - halfBlockSize);

      var yDist = 0.8 * (endOffset.dy - startOffset.dy);
      var xDist = 0.8 * (endOffset.dx - startOffset.dx);

      var paint = Paint()
        ..strokeWidth = halfBlockSize * 0.8
        ..color = arrow.color;

      canvas.drawLine(startOffset,
          Offset(startOffset.dx + xDist, startOffset.dy + yDist), paint);

      var slope =
          (endOffset.dy - startOffset.dy) / (endOffset.dx - startOffset.dx);

      var newLineSlope = -1 / slope;

      var points = _getNewPoints(
          Offset(startOffset.dx + xDist, startOffset.dy + yDist),
          newLineSlope,
          halfBlockSize);
      var newPoint1 = points[0];
      var newPoint2 = points[1];

      var path = Path();

      path.moveTo(endOffset.dx, endOffset.dy);
      path.lineTo(newPoint1.dx, newPoint1.dy);
      path.lineTo(newPoint2.dx, newPoint2.dy);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  List<Offset> _getNewPoints(Offset start, double slope, double length) {
    if (slope == double.infinity || slope == double.negativeInfinity) {
      return [
        Offset(start.dx, start.dy + length),
        Offset(start.dx, start.dy - length)
      ];
    }

    return [
      Offset(start.dx + (length / sqrt(1 + (slope * slope))),
          start.dy + ((length * slope) / sqrt(1 + (slope * slope)))),
      Offset(start.dx - (length / sqrt(1 + (slope * slope))),
          start.dy - ((length * slope) / sqrt(1 + (slope * slope)))),
    ];
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) {
    return arrows != oldDelegate.arrows;
  }
}
