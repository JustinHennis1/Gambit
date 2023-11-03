import 'package:dio/dio.dart';

Future<bool> isUserAvailable(String username) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response = await dio.get('$baseUrl/finduser/$username');
    print (response.statusCode);
    if (response.statusCode == 200) {
      // User not found, username is available
      return true;
    } else if (response.statusCode == 404) {
      // User found, username is unavailable
      return false;
    } else {
      // Handle other status codes if needed
      return false;
    }
  } catch (e) {
    // Handle Dio errors
    print(e);
    return false;
  }
}

void main() async {
  final username = 'example_username'; // Replace with the username you want to check
  final isAvailable = await isUserAvailable(username);

  print('Is username available? $isAvailable');
}
