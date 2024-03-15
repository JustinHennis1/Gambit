import 'package:dio/dio.dart';

class Message {
  final String content;
  final String timestamp;
  final String sender;

  Message(this.content, this.timestamp, this.sender);
}

Future<Map<String, List<Message>>?> getMessages(
    String sender, String receiver) async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000'; // Change this based on your API URL

  try {
    final response = await dio.get(
      '$baseUrl/messages/sent/',
      data: {'sender_username': sender, 'recipient_username': receiver},
    );
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('inside 200 getmsg');
      List<dynamic> messages = response.data;

      // Separate messages based on sender and receiver
      List<Message> sentMessages = [];
      List<Message> receivedMessages = [];

      // Sort messages by timestamp from newest to oldest
      messages.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

      // Iterate through messages and categorize them
      for (dynamic msg in messages) {
        String content = msg['message_content'].toString();
        String time = msg['timestamp'].toString();
        String messageOwner = msg['sender_username'].toString();

        Message message = Message(content, time, messageOwner);

        if (messageOwner == sender) {
          sentMessages.add(message);
        } else if (messageOwner == receiver) {
          receivedMessages.add(message);
        }
      }

      return {
        'sentMessages': sentMessages,
        'receivedMessages': receivedMessages,
      };
    } else {
      print('Error: ${response.statusCode}, ${response.statusMessage}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

// void main() async {
//   // Replace 'sender' and 'receiver' with your actual test values
//   final sender = 'Jbeezy';
//   final receiver = 'AmanFlutterGod';

//   // Call the function and wait for the result
//   Map<String, List<String>>? messageMap = await getMessages(sender, receiver);

//   if (messageMap != null) {
//     // Access sentMessages and receivedMessages
//     List<String> sentMessages = messageMap['sentMessages'] ?? [];
//     List<String> receivedMessages = messageMap['receivedMessages'] ?? [];

//     // Print the retrieved message content for manual verification
//     print('Sent Messages: $sentMessages');
//     print('Received Messages: $receivedMessages');
//   } else {
//     print('Failed to retrieve messages.');
//   }
// }
