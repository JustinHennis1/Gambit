import 'dart:io';
import 'dart:convert';

Future<String> runStockfish(String fen) async {
  const stockfishPath =
      'stockfish/src/stockfish.exe'; // Adjust the path as needed

  final process = await Process.start(stockfishPath, []);

  process.stdin.writeln('uci');
  process.stdin.writeln('isready');
  process.stdin.writeln('position fen $fen');
  process.stdin.writeln('go depth 1');

  await process.stdin.flush();
  await process.stdin.close();

  final result = await process.stdout.transform(utf8.decoder).join();

  return result;
}

void main() async {
  stdout.write('Enter FEN string: ');
  final fen = stdin.readLineSync();

  final result = await runStockfish(fen!);

  print(result);

  exit(0);
}
