import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gambit/services/addmsg.dart';
import 'package:gambit/services/getmessages.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageMe extends StatelessWidget {
  final String title;
  final String currentUser;
  final String recipientUser;

  const MessageMe({
    super.key,
    required this.title,
    required this.currentUser,
    required this.recipientUser,
  });

  @override
  Widget build(BuildContext context) {
    return RealTimeMessage(
      title: title,
      currentUser: currentUser,
      recipientUser: recipientUser,
    );
  }
}

class RealTimeMessage extends StatefulWidget {
  final String title;
  final String currentUser;
  final String recipientUser;

  const RealTimeMessage({
    super.key,
    required this.title,
    required this.currentUser,
    required this.recipientUser,
  });

  @override
  State<RealTimeMessage> createState() => _Real();
}

class _Real extends State<RealTimeMessage> {
  final TextEditingController _messageController = TextEditingController();
  late WebSocketChannel channel;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<Map<String, dynamic>> messages = [];
  List<Map<String, String>> oldmessages = [];
  String temp = '';

  @override
  void initState() {
    super.initState();
    getmsgs();
    _connectToWebSocket();
  }

  Future<void> getmsgs() async {
    Map<String, List<Message>>? retrievedMessages =
        await getMessages(widget.currentUser, widget.recipientUser) ??
            {
              'sentMessages': [],
              'receivedMessages': [],
            };

    // Merge and sort messages by timestamp
    List<Message> allMessages = [
      ...retrievedMessages['sentMessages']!,
      ...retrievedMessages['receivedMessages']!,
    ];

    allMessages.sort((b, a) => a.timestamp.compareTo(b.timestamp));

    setState(() {
      oldmessages = allMessages
          .map((message) => {
                'content': message.content,
                'timestamp': message.timestamp,
                'sender': message.sender,
              })
          .toList();
    });
  }

  Future<void> _handleRefresh() async {
    await getmsgs();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight * 1.5),
        child: AppBar(
          toolbarHeight: appBarHeight * 4,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black87, fontFamily: 'San Francisco'),
          ),
          backgroundColor: Colors.amber.withOpacity(0.8),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        // padding: EdgeInsets.only(top: appBarHeight),
        decoration: const BoxDecoration(color: Colors.black87),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: oldmessages.length + messages.length,
                    itemBuilder: (context, index) {
                      if (index < messages.length) {
                        final message = messages[index];
                        final isSentMessage =
                            message['sender'] == widget.currentUser;

                        return Align(
                          alignment: isSentMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: isSentMessage ? Colors.blue : Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message['content'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        final oldmessage = oldmessages[index - messages.length];
                        final isSentMessage =
                            oldmessage['sender'] == widget.currentUser;

                        return Align(
                          alignment: isSentMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: isSentMessage ? Colors.blue : Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              oldmessage['content'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _messageController,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                          decoration: const InputDecoration(
                              labelText: 'Send a message',
                              labelStyle: TextStyle(color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.amber.withOpacity(0.8)),
                        onPressed: () async {
                          setState(() {
                            temp = _messageController.text;
                          });
                          _messageController.clear();
                          _sendMessage();
                          await Future.delayed(const Duration(seconds: 1), () {
                            String message = temp.trim();

                            addMessage(
                              widget.currentUser,
                              widget.recipientUser,
                              message,
                            );
                          });
                        },
                        child: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _connectToWebSocket() {
    // Connect to the WebSocket server
    channel = IOWebSocketChannel.connect('ws://10.0.2.2:3000');

    // Send the current user's username to the server
    channel.sink.add(jsonEncode({
      'type': 'username',
      'username': widget.currentUser,
    }));

    // Listen for messages and update the state with the content
    channel.stream.listen((data) {
      final message = jsonDecode(data);
      if (message['content'] != null) {
        setState(() {
          messages.insert(0, message);
        });
      }
    });
  }

  void _sendMessage() {
    String message = temp.trim();
    //print(message);
    if (message.isNotEmpty) {
      // Create a JSON message with the recipient, content, and sender
      // print(message);
      Map<String, dynamic> data = {
        'type': 'private_message',
        'recipient': widget.recipientUser,
        'content': message,
        'sender': widget.currentUser,
      };

      // Add the message to the recently sent messages list
      //recentlySentMessages.add(data);

      String jsonString = jsonEncode(data);

      // Send the message to the server
      // print(jsonString);
      channel.sink.add(jsonString);

      //addMessage(widget.currentUser, widget.recipientUser, message);
      // Clear the input field
    }
  }

  @override
  void dispose() {
    //_disposeMessagesSequentially().then((_) {
    // After all messages are processed, close the channel
    channel.sink.close();
    super.dispose();
    //});
  }

  // Future<void> _disposeMessagesSequentially() async {
  //   await Future.forEach(recentlySentMessages, (message) async {
  //     // Add a delay between each call to addMessage
  //     await Future.delayed(const Duration(seconds: 1), () {
  //       addMessage(
  //         widget.currentUser,
  //         widget.recipientUser,
  //         message['content'],
  //       );
  //     });
  //   });
  // }
}
