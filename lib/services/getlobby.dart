import 'package:dio/dio.dart';

Future<dynamic> getLobby(var choice) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    if (choice == 0) {
      choice = '';
    }
    final response = await dio.get('$baseUrl/getlobby$choice');
    if (response.statusCode == 200) {
      final responseData = response.data;
      // if (responseData is Map && responseData.containsKey('rating')) {
      //   final rating = responseData['rating'];

      //   return rating;
      print(responseData);

      return responseData;
    }
  } catch (e) {
    if (e is DioException) {
      return 'Dio response: ${e.response?.data}';
    }
    return 'Dio response: $e';
  }
}
