import 'package:flutter/material.dart';
import 'package:gambit/services/delreq.dart';
import 'package:gambit/services/getfriends.dart';
import 'package:gambit/services/removefromfriendslist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsList extends StatefulWidget {
  final String currentuser;
  const FriendsList({super.key, required this.currentuser});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<String>? friendstemp;
  Color colormarker = Colors.black.withOpacity(0.4);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () async {
      await getFriends();
    });
  }

  Future getFriends() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    var fusernames = await getAcceptedFriends(obtainedUsername ?? "");
    //print('Friend Usernames: $fusernames');
    sharedPreferences.setStringList("friends", fusernames ?? []);

    setState(() {
      friendstemp = fusernames;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (friendstemp == null || friendstemp!.isEmpty) {
      // Display a message when the list is empty
      return GestureDetector(
        onTap: () => getFriends(),
        child: const Center(
          child: Text(
            'Add Friends',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: friendstemp!.length,
      itemBuilder: (context, index) {
        final username = friendstemp![index];

        return ListTile(
            title: Text(
              username,
              style: const TextStyle(color: Colors.white54),
            ),
            trailing: ElevatedButton(
                autofocus: false,
                onFocusChange: (value) {
                  colormarker = Colors.blueGrey.withOpacity(0.8);
                },
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        actions: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blueGrey.shade300,
                                  Colors.blueGrey.shade600
                                ]),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: Expanded(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await removeFriendFromList(
                                            username, widget.currentuser);
                                        await deleteFriend(
                                            username, widget.currentuser);
                                        setState(() {
                                          getFriends();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(fontSize: 15),
                                      )),
                                  const TextButton(
                                      onPressed: null,
                                      child: Text("View Profile",
                                          style: TextStyle(fontSize: 15))),
                                  const TextButton(
                                      onPressed: null,
                                      child: Text("Message",
                                          style: TextStyle(fontSize: 15)))
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return colormarker; // Default  color
                    },
                  ),
                ),
                child: const Icon(
                  Icons.more_horiz_rounded,
                  color: Colors.amber,
                )));
      },
    );
  }
}
