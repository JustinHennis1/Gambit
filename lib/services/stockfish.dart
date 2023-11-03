import 'dart:convert';
import 'dart:io';

//  Basic call to Stockfish executable to test output
// adjust depth and time to adjust difficulty level
//  of computer player

Future<String> runStockfish(String fen, int depth, int time) async {
  const stockfishPath =
      "C://Users//15hen//OneDrive//Desktop//Coursework//MobileDev//gambit//lib//stockfish//src//stockfish.exe"; // Adjust the path as needed

  final process = await Process.start(stockfishPath, []);

  process.stdin.writeln('uci');
  process.stdin.writeln('isready');
  process.stdin.writeln('position fen $fen');
  process.stdin.writeln('go movetime $time'); //time in ms
  process.stdin.writeln('go depth $depth'); //how many moves ahead depth

  await process.stdin.flush();
  await process.stdin.close();

  final result = await process.stdout.transform(utf8.decoder).join();

  // Parse the result to extract the best move
  final bestMoveIndex = result.indexOf('bestmove');
  if (bestMoveIndex != -1) {
    final bestMoveLine = result.substring(bestMoveIndex);
    final bestMove = bestMoveLine.split(' ')[1];
    return bestMove;
  } else {
    return 'No best move found';
  }
}

void main() async {
  try {
    String fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
    final result = await runStockfish(
        fen, 10, 5000); // Replace 'your_fen' with an actual FEN string
    print('Best Move: $result');
  } catch (e) {
    print('Error: $e');
  }
}
