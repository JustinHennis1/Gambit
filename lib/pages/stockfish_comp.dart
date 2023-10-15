import 'dart:io';
import 'dart:async';
import 'dart:convert';

class StockfishPlayer {
  late Process _stockfishProcess;
  late StreamController<String> _outputController;

  StockfishPlayer(String stockfishPath) {
    _outputController = StreamController<String>();
    _startStockfish(stockfishPath);
  }

  Future<void> _startStockfish(String stockfishPath) async {
    _stockfishProcess = await Process.start(stockfishPath, []);
    _stockfishProcess.stdout.transform(utf8.decoder).listen((String data) {
      _outputController.add(data);
    });

    _stockfishProcess.stderr.transform(utf8.decoder).listen((String data) {
      print('Stockfish Error: $data');
    });

    _stockfishProcess.stdin.writeln('uci');
    _stockfishProcess.stdin.writeln('isready');
    _stockfishProcess.stdin.writeln('ucinewgame');
  }

  Future<String> getBestMove(String fen) async {
    Completer<String> moveCompleter = Completer<String>();

    _outputController.stream.listen((String output) {
      if (output.startsWith('bestmove')) {
        List<String> parts = output.split(' ');
        String bestMove = parts[1];
        moveCompleter.complete(bestMove);
      }
    });

    _stockfishProcess.stdin.writeln('position fen $fen');
    _stockfishProcess.stdin
        .writeln('go movetime 1000'); // Adjust movetime as needed

    return moveCompleter.future;
  }

  Future<void> dispose() async {
    _stockfishProcess.stdin.writeln('quit');
    await _outputController.close();
  }
}
