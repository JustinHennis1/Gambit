import 'package:dio/dio.dart';

Future<String> getBestMove(String fen, int depth, int time) async {
  assert(depth <= 13 && depth >= 1);
  final dio = Dio();

  try {
    final response = await dio.get(
      "http://10.0.2.2:8080/getBestMove",
      queryParameters: {
        'fen': fen,
        'depth': depth,
        'time': time,
      },
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
    const fen = 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1';

    // Adjust the depth as needed
    final depth = 1;

    final result = await getBestMove(fen, depth, 100);
    print('Best Move: $result');
  } catch (e) {
    print('Error: $e');
  }
}
