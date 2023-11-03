import 'package:flutter/material.dart';
import 'package:gambit/chesslogic/game_components/piece.dart';
import 'package:gambit/chesslogic/game_components/square.dart';
import 'package:gambit/chesslogic/helper/helper_methods.dart';
import 'package:gambit/chesslogic/values/colors.dart';
import 'package:gambit/controllers/tabcontrol.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/home_page.dart';
import 'package:get/get.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
// A 2-dimensional list representiong the chessboard,
// with each position possibly containing a chess piece
  late List<List<ChessPiece?>> board;

  //the currently selected piece
  // if no piece is selected this is null
  ChessPiece? selectedPiece;

  // The row index of the selected piece
  // default value -1 means nothing selected
  int selectedRow = -1;

  // The col index of the selected piece
  // default value -1 means nothing selected
  int selectedCol = -1;

  // A list of valid moves for the currently selected piece
  // each move is represented as a list with 2 elements: row and col
  List<List<int>> validMoves = [];

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

// Initialize the board
  void _initializeBoard() {
    // initialize the board with nulls, meaning no pieces in thos positions
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    // place random piece in the middle to check
    newBoard[3][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bq.png');

    // Place Pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: false,
          imagePath: 'assets/images/chesspieces/bp.png');
      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: true,
          imagePath: 'assets/images/chesspieces/bp.png');
    }

    // place rooks
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/br.png');
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/br.png');
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/br.png');
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/br.png');

    // place knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bn.png');
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bn.png');
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bn.png');
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bn.png');

    // place bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bb.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bb.png');
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bb.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bb.png');

    // place queens
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bq.png');
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bq.png');

    // place kings
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'assets/images/chesspieces/bk.png');
    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: 'assets/images/chesspieces/bk.png');

    board = newBoard;
  }

  //User selected a piece
  void pieceSelected(int row, int col) {
    setState(() {
      if (selectedPiece == null && board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      } else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      // If a piece is elected and user taps on another square
      else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }
      // If a piece is selected, calculate its valid moves
      validMoves =
          calculateRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  // CALCULATE RAW VALID MOVES
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    //different directions based on their color
    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
// horizontal and vertical directions
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        // all eight possible L moves knight can move
        var knightMoves = [
          [-2, -1],
          [-2, 1],
          [-1, -2],
          [-1, 2],
          [1, -2],
          [1, 2],
          [2, -1],
          [2, 1]
        ];
        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
      case ChessPieceType.bishop:
        // diagonal directions
        var directions = [
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1]
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }

        break;
      case ChessPieceType.queen:
        // all eight directions
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }

        break;
      case ChessPieceType.king:
        // all eight directions one space deep
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];
        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
      default:
    } // YouTube 27:53

    return candidateMoves;
  }

// MOVE PIECE
  void movePiece(int newRow, int newCol) {
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // clear selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87, actions: [
        BackButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BaseScreen(0)));
          },
        )
      ]),
      //backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 100, bottom: 100),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
            itemCount: 8 * 8,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8),
            itemBuilder: ((context, index) {
              // get the row and the column position of this square
              int row = index ~/ 8;
              int col = index % 8;

              // check if this square is selected
              bool isSelected = selectedRow == row && selectedCol == col;

              // check if move is valid
              bool isValidMove = false;
              for (var position in validMoves) {
                if (position[0] == row && position[1] == col) {
                  isValidMove = true;
                }
              }
              return Square(
                isWhite: isWhite(index),
                piece: board[row][col],
                isValidMove: isValidMove,
                isSelected: isSelected,
                onTap: () => pieceSelected(row, col),
              );
            })),
      ),
    );
  }
}
