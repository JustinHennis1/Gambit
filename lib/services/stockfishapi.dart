import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

//  Uses Stockfish compiled on my machine to create an api at
//  port 8080,
//

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

Handler _apiRouter() {
  final router = Router();

  router.get('/getBestMove', (Request request) async {
    final queryParameters = request.url.queryParameters;
    final fen = queryParameters['fen'];
    final depth = int.tryParse(queryParameters['depth'] ?? '');
    if (fen == null || depth == null) {
      return Response.notFound('Invalid request parameters');
    }

    try {
      final result = await runStockfish(fen, depth, 5000);
      return Response.ok(result);
    } catch (e) {
      return Response.internalServerError(body: 'Error: $e');
    }
  });

  return router;
}

void main() {
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_apiRouter());

  shelf_io.serve(handler, 'localhost', 8080).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}
