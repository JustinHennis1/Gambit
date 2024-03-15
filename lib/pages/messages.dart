import 'package:flutter/material.dart';
import 'package:gambit/services/addmsg.dart';
import 'package:gambit/services/getmessages.dart';

class Messager extends StatefulWidget {
  const Messager({
    super.key,
    required this.title,
    required this.sender,
    required this.receiver,
  });

  final String title;
  final String receiver;
  final String sender;

  @override
  State<Messager> createState() => _MessagerState();
}

class _MessagerState extends State<Messager> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState;

    // Delay the initial loading of messages to allow the UI to settle
    Future.delayed(Duration.zero, () {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  List<Map<String, String>> messages = [];

  Future<void> getmsgs() async {
    Map<String, List<Message>>? retrievedMessages =
        await getMessages(widget.sender, widget.receiver) ??
            {
              'sentMessages': [],
              'receivedMessages': [],
            };

    // Merge and sort messages by timestamp
    List<Message> allMessages = [
      ...retrievedMessages['sentMessages']!,
      ...retrievedMessages['receivedMessages']!,
    ];

    allMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    setState(() {
      messages = allMessages
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
    double appBarHeight = MediaQuery.of(context).size.height * 0.50;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight * 1.5,
        title: SizedBox(
          height: appBarHeight,
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black87, fontFamily: 'San Francisco'),
          ),
        ),
        backgroundColor: Colors.amber.withOpacity(0.8),
      ),
      backgroundColor: Colors.black87,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  // Display messages
                  return ListTile(
                    title: Align(
                      alignment: messages[index]['sender'] == widget.sender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: messages[index]['sender'] == widget.sender
                              ? const Radius.circular(120)
                              : const Radius.circular(80),
                          topRight: messages[index]['sender'] == widget.sender
                              ? const Radius.circular(50)
                              : const Radius.circular(120),
                          bottomLeft: messages[index]['sender'] == widget.sender
                              ? const Radius.circular(120)
                              : const Radius.circular(-20),
                          bottomRight:
                              messages[index]['sender'] == widget.sender
                                  ? const Radius.circular(-20)
                                  : const Radius.circular(120),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: messages[index]['sender'] == widget.sender
                              ? Colors.blue
                              : Colors.grey.shade800,
                          child: Text(
                            '${messages[index]['content']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'San Francisco'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
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
                    onPressed: () {
                      _sendMessage(
                        widget.sender,
                        widget.receiver,
                        _controller.text,
                      );
                      _controller.text = '';
                    },
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String sender, String receiver, String message) async {
    if (_controller.text.isNotEmpty) {
      await addMessage(sender, receiver, message);
      await _handleRefresh();
    }
  }
}
