import 'package:dio/dio.dart';

Future<List<String>?> getAcceptedFriends(String username) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    print("username is $username ");
    final response = await dio.get(
      '$baseUrl/get_accepted_friends',
      data: {'desired_username': username},
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');

    if (response.statusCode == 200) {
      final List<dynamic>? usernames = response.data['usernames'];

      if (usernames != null) {
        // Convert the dynamic list to a list of strings
        final List<String> usernameList = usernames.map((dynamic username) {
          return username.toString();
        }).toList();

        return usernameList;
      } else {
        return null;
      }
    } else {
      // Handle other status codes if needed
      return null;
    }
  } catch (e) {
    // Handle Dio errors
    print('Dio Error: $e');
    return null;
  }
}
