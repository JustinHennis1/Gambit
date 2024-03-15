import 'package:flutter/material.dart';

import 'package:gambit/components/friendslist.dart';
import 'package:gambit/components/pendinglist.dart';

import 'package:gambit/components/usernamelist.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/converse.dart';
import 'package:gambit/pages/realtime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  String? username;
  List<String>? usernames;
  List<String>? pendinglist;
  List<String>? friendstemp;
  TextEditingController finduser = TextEditingController();

  List<String>? filteredUsernames;

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    //print('Setting Username In SocialPage to $obtainedUsername');

    setState(() {
      username = obtainedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;

    var inviteScreen = const UsernamesListView();

    var friendScreen = Column(
      children: [
        const Row(
          children: [
            SizedBox(
              height: 40,
              width: 20,
            ),
            Text(
              "Friends",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            constraints: BoxConstraints.tight(const Size.fromHeight(150)),
            height: 90,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              //borderRadius: BorderRadius.circular(50)
            ),
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                        child: FriendsList(
                      currentuser: username ?? "",
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    var pendingScreen = Column(
      children: [
        const Row(
          children: [
            SizedBox(
              height: 40,
              width: 20,
            ),
            Text(
              "Pending Friend Requests",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            constraints: BoxConstraints.tight(const Size.fromHeight(150)),
            height: 90,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              //borderRadius: BorderRadius.circular(50)
            ),
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      //child: pendlist(pendinglist, username ?? ""),
                      child: PendingList(
                        currentuser: username,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    void getHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen(0)),
        (route) => false,
      );
    }

    void getToMessages() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ConversationScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: appBarHeight,
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: SizedBox(
          height: 90,
          child: GestureDetector(
            onDoubleTap: getHome,
            child: Image.asset('assets/images/prodigy1.png'),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              //height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: const AssetImage('assets/images/social.jpg'),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.95),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black87),
                      child: inviteScreen, // Invite Screen at top
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 240,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87),
                        child: friendScreen), // Friend Screen View in Middle
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 240,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87),
                        child: pendingScreen), //Pending Request At Bottom
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: getToMessages,
              backgroundColor: Colors.white,
              child: const Icon(Icons.chat, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
