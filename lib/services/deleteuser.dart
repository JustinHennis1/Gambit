import 'package:dio/dio.dart';

Future<bool> deleteUser(String username) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response = await dio.delete(
      '$baseUrl/delete_user/$username', // Include the username in the URL
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      // User added successfully
      return true;
    } else if (response.statusCode == 409) {
      // User already exists, username is unavailable
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
