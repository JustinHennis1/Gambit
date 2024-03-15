import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gambit/components/start_logo.dart';
import 'package:gambit/pages/pvp_blk.dart';
import 'package:gambit/services/delete_fromlob.dart';
import 'package:gambit/services/getlobby.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LobbyPage extends StatefulWidget {
  final int choice;
  final String username;

  const LobbyPage({Key? key, required this.choice, required this.username})
      : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late Future<dynamic> lobbyData;
  String? username;

  @override
  void initState() {
    super.initState();
    lobbyData = getLobby(widget.choice);
    getValidationData();
  }

  Future<void> getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final obtainedUsername = sharedPreferences.getString('username');

    setState(() {
      username = obtainedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FutureBuilder<dynamic>(
            future: lobbyData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<dynamic> users = snapshot.data;

                // Sort the users based on their 'rating'
                users.sort((a, b) => b['rating'].compareTo(a['rating']));

                if (users.length >= 2) {
                  final player1 = users[0];
                  final player2 = users[1];

                  if (username == player1['username'] ||
                      username == player2['username']) {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PVPblack(
                              player1['username'], player2['username']),
                        ),
                      );
                    });
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoBox(
                      imagePath: 'assets/images/gambit2.png',
                      logoHt: 250,
                    ),
                    Text(
                      '${users.length} Players in Lobby',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
