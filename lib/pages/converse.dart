import 'package:flutter/material.dart';
import 'package:gambit/pages/messages.dart';
import 'package:gambit/pages/realtime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight * 1.5,
        centerTitle: true,
        title: const Text('Conversations'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: const ConversationList(),
    );
  }
}

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  String keys = DateTime.now().millisecondsSinceEpoch.toString();
  List<String> conversations = [];
  List<bool> isSelectedList = [];
  String currentuser = '';

  Future getfriends() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var user = sharedPreferences.get('username').toString();
    setState(() {
      currentuser = user;
      conversations = sharedPreferences.getStringList("friends") ?? [];
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await getfriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      child: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Colors.black,
            onTap: () {
              // Handle the action when a conversation is tapped
              // This could navigate to the selected conversation
              // For simplicity, let's print a message for now
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessageMe(
                        title: conversations[index],
                        currentUser: currentuser,
                        recipientUser: conversations[index])
                    // Messager(
                    //   title: conversations[index],
                    //   sender: currentuser,
                    //   receiver: conversations[index],
                    // ),
                    ),
              );
            },
            child: Container(
              color: Colors.white10,
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black87,
                    height: 5,
                    thickness: 4,
                  ),
                  ListTile(
                    title: Text(
                      conversations[index],
                      style: const TextStyle(color: Colors.amber),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  const Divider(
                    color: Colors.black87,
                    height: 5,
                    thickness: 4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
