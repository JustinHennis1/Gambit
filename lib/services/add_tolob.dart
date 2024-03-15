import 'package:dio/dio.dart';

Future<dynamic> addtoLobby(var choice, String username, var rating) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    if (choice == 0) {
      choice = '';
    }
    final response = await dio
        .post('$baseUrl/addtolobby$choice/$username', data: {'rating': rating});
    if (response.statusCode == 200) {
      final responseData = response.data;
      // print(responseData);
      // print('player added to lobby $choice');
      return responseData;
    }
  } catch (e) {
    if (e is DioException) {
      return 'Dio response: ${e.response?.data}';
    }
    return 'Dio response: $e';
  }
}
