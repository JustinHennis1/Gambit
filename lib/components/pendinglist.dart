import 'package:flutter/material.dart';
import 'package:gambit/components/acceptbutton.dart';
import 'package:gambit/services/acceptfriend.dart';
import 'package:gambit/services/add_tolist.dart';
import 'package:gambit/services/getpending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingList extends StatefulWidget {
  final String? currentuser;

  const PendingList(
      {super.key,required this.currentuser});

  @override
  State<PendingList> createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  List<String>? pendinglist;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      await getPending();
    });
  }

  Future<void> getPending() async {
    var obtainedUsername = widget.currentuser;
    print('My Username is: $obtainedUsername');
    var retrievedPendinglist = await getAllPending(obtainedUsername ?? '');
    print('Pending usernames are $retrievedPendinglist');
    setState(() {
      pendinglist = retrievedPendinglist ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pendinglist == null || pendinglist!.isEmpty) {
      // Display a message when the list is empty
      return const Center(
        child: Text(
          'Add Friends',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      itemCount: pendinglist!.length,
      itemBuilder: (context, index) {
        final username = pendinglist![index];

        return ListTile(
          title: Text(
            username,
            style: const TextStyle(color: Colors.white54),
          ),
          trailing: AcceptButton(
            onPressed: () async {
              if (widget.currentuser != null && widget.currentuser != "") {
                await addFriendToList(username, widget.currentuser!);
                await acceptFriend(username, widget.currentuser!);
                setState(() {
                  getPending();
                });
              }
            },
          ),
        );
      },
    );
  }
}
