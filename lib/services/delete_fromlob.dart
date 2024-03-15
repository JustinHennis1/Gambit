import 'package:dio/dio.dart';

Future<dynamic> deletefromLobby(var choice, String username) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    if (choice == 0) {
      choice = '';
    }
    //print('$baseUrl/deletefromlob$choice/$username');
    final response =
        await dio.delete('$baseUrl/deletefromlob$choice/$username');
    if (response.statusCode == 200) {
      final responseData = response.data;
      // print(responseData);
      // print('player deleted from lobby $choice');
      return responseData;
    }
  } catch (e) {
    if (e is DioException) {
      return 'Dio response: ${e.response?.data}';
    }
    return 'Dio response: $e';
  }
}
