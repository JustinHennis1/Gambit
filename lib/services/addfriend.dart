import 'package:dio/dio.dart';

Future<bool> addNewFriend(String sender, String receiver) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000';

  try {
    final response = await dio.post('$baseUrl/add_friend_request',
        data: {'sender_username': sender, 'receiver_username': receiver});

    print(response.statusCode);

    if (response.statusCode == 201) {
      // friend request sent successfully
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
