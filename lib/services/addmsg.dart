import 'package:dio/dio.dart';

Future<dynamic> addMessage(
    String sender, String receiver, String message) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response = await dio.post('$baseUrl/messages/add', data: {
      'sender_username': sender,
      'recipient_username': receiver,
      'message_content': message
    });
    if (response.statusCode == 200) {
      return 'success message added';
    } else {
      return 'Unexpected response format';
    }
  } catch (e) {
    if (e is DioException) {
      return 'Dio response: ${e.response?.data}';
    }
    return 'Dio response: ${e}';
  }
}
