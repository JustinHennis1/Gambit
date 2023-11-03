import 'package:dio/dio.dart';

Future<String> getBestMove(String fen, int depth) async {
  assert(depth <= 13 && depth >= 1);
  final dio = Dio();

  try {
    final response = await dio.get(
      "https://stockfish.online/api/stockfish.php",
      queryParameters: {'fen': fen, 'depth': depth, 'mode': 'bestmove'},
    );

    final result = parseStockfishResult(response.data.toString());
    return result;
  } on DioException catch (e) {
    print('DioError: $e');
    if (e.response != null) {
      print('Response status code: ${e.response!.statusCode}');
      print('Response data: ${e.response!.data}');
    }
    throw e;
  }
}

String parseStockfishResult(String result) {
  const marker = 'bestmove';
  final index = result.indexOf(marker);

  if (index != -1) {
    // Print everything after "bestmove"
    final extractedResult = result.substring(index + marker.length).trim();

    // Remove any trailing '}'
    return extractedResult.endsWith('}')
        ? extractedResult.substring(0, extractedResult.length - 1)
        : extractedResult;
  } else {
    // If marker is not found, return the original result
    return result;
  }
}

void main() async {
  try {
    const fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

    // Adjust the depth as needed
    final depth = 3;

    final result = await getBestMove(fen, depth);
    print('Best Move: $result');
  } catch (e) {
    print('Error: $e');
  }
}
