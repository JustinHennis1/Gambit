import 'package:dio/dio.dart';

Future<dynamic> isRatingAvailable(String username) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response = await dio.get('$baseUrl/get_rating/$username');
    if (response.statusCode == 200) {
      final responseData = response.data;
      if (responseData is Map && responseData.containsKey('rating')) {
        final rating = responseData['rating'];

        return rating;
      } else {
        return 'Unexpected response format: $responseData';
      }
    } else {
      return 'Unexpected status code: ${response.statusCode}';
    }
  } catch (e) {
    if (e is DioException) {
      return 'Dio response: ${e.response?.data}';
    }
    return 'Dio response: ${e}';
  }
}
