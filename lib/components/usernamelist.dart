import 'package:flutter/material.dart';
import 'package:gambit/components/invitebutton.dart';
import 'package:gambit/services/addfriend.dart';
import 'package:gambit/services/getfriends.dart';
import 'package:gambit/services/getpending.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gambit/services/getallusernames.dart';

class UsernamesListView extends StatefulWidget {
  const UsernamesListView({super.key});

  @override
  State<UsernamesListView> createState() => _UsernamesListViewState();
}

class _UsernamesListViewState extends State<UsernamesListView> {
  String? currentuser;
  List<String>? usernames;
  List<String>? pendinglist;
  List<String>? friendstemp;
  List<String>? filteredUsernames;
  TextEditingController finduser = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 2000), () async {
      await getValidationData();

      await getFriends();
      await getPending();
      await getUsernames();
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');

    setState(() {
      currentuser = obtainedUsername;
    });
  }

  Future getUsernames() async {
    var obtainedUsernames = await getAllUsernames();
    await getPending();
    await getFriends();
    final List<String> friendsAndPending = [...?friendstemp, ...?pendinglist];
    //print('inside getusernames: $friendsAndPending');
    setState(() {
      usernames = obtainedUsernames
          ?.where((username) =>
              username != currentuser && !friendsAndPending.contains(username))
          .toList();

      filteredUsernames =
          usernames; // Initialize filteredUsernames with the filtered list
    });
  }

  Future getPending() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    //print('My Username is: $obtainedUsername');
    pendinglist = await getAllPending(obtainedUsername ?? '');
    //print('Pending usernames are $pendinglist');
    setState(() {
      pendinglist = pendinglist ?? [];
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

  void filterUsernames(String query) {
    setState(() {
      filteredUsernames = usernames
          ?.where((username) =>
              username.toLowerCase().contains(query.toLowerCase()) &&
              username != currentuser &&
              !friendstemp!.contains(username) &&
              !pendinglist!.contains(username))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: TextField(
            style: const TextStyle(
                color: Colors.white54,
                fontFamily: 'Times New Roman',
                decorationColor: Colors.red),
            enableInteractiveSelection: true,
            maxLength: 254,
            showCursor: true,
            cursorColor: Colors.white,
            controller: finduser,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: const TextStyle(
                  color: Colors.white54, fontFamily: 'Times New Roman'),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
            ),
            onChanged: (value) {
              filterUsernames(value); // Call filter function on text change
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
          child: Container(
            constraints: BoxConstraints.tight(const Size.fromHeight(190)),
            height: 250,
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
                      child: ListView.builder(
                        itemCount: filteredUsernames?.length,
                        itemBuilder: (context, index) {
                          final username = filteredUsernames?[index];

                          return ListTile(
                            title: Text(
                              username ?? "Loading...",
                              style: const TextStyle(color: Colors.white54),
                            ),
                            trailing: InviteButton(
                              onPressed: () {
                                if (currentuser != null && username != null) {
                                  addNewFriend(currentuser ?? "", username);
                                }
                                setState(() {
                                  finduser.text = '';
                                  filterUsernames("");
                                  getUsernames();
                                });
                              },
                            ),
                          );
                        },
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
  }
}
