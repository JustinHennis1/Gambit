// computer_player.dart
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:gambit/pages/stockfish_fen.dart';

class ComputerPlayer {
  final ChessBoardController controller;

  ComputerPlayer(this.controller);

  Future<void> moveIt() async {
    // Get the current FEN from the chess board controller
    final currentFEN = controller.getFen();
    print('currentFen =  $currentFEN');
    // Query the API to get the best move
    final result = await getBestMove(currentFEN);
    print('Result = $result');
    var move1 = result.toString().substring(0, 2);
    print('Move1 = $move1');
    var move2 = result.toString().substring(2, 4);
    print('Move2 = $move2');
    controller.makeMove(from: move1, to: move2);
  }
}
