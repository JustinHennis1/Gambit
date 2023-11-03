import 'package:dio/dio.dart';

Future<String?> getUsernameByEmail(String email) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response =
        await dio.post('$baseUrl/get_username', data: {'email': email});
    print(response.statusCode);

    if (response.statusCode == 200) {
      final username = response.data['username'];
      return username;
    } else {
      // Handle other status codes if needed
      return null;
    }
  } catch (e) {
    // Handle Dio errors
    print(e);
    return null;
  }
}
