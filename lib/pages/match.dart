import 'package:flutter/material.dart';
import 'package:gambit/components/texttheme.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/lobby.dart';
import 'package:gambit/services/add_tolob.dart';
import 'package:gambit/services/delete_fromlob.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    String username = '';
    int userRating = 0;
    int choice = 0;

    void getHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen(0)),
        (route) => false,
      );
    }

    void getToLobby() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LobbyPage(
            choice: choice,
            username: username,
          ),
        ),
      );
    }

    @override
    void dispose() {
      // Call deletefromlob when the page is disposed
      deletefromLobby(choice, username);
      super.dispose();
    }

    Future getValidationData() async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      var obtainedUsername = sharedPreferences.getString('username') ?? '';
      var obtainedrating = sharedPreferences.getInt('rating') ?? 0;
      print('$obtainedUsername : $obtainedrating');
      setState(() {
        username = obtainedUsername;
        userRating = obtainedrating;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: SizedBox(
            height: appBarHeight,
            child: GestureDetector(
                onDoubleTap: getHome,
                child: Image.asset('assets/images/prodigy1.png'))),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/lo.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: TextTheme2('Matchmaking:'),
                    ),
                  ],
                )),
            Container(
              height: 400,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.35),
                  border: Border.all(
                      color: Colors.white24,
                      style: BorderStyle.solid,
                      width: 3.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 0;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "5 | 0",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 1;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "5 | 5",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 2;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "10 | 0",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 3;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "10 | 5",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 4;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "15 | 0",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 5;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "15 | 5",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 6;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "30 | 0",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 7;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "60 | 0",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                      TextButton(
                          onPressed: () async {
                            await getValidationData();
                            setState(() {
                              choice = 8;
                            });
                            await addtoLobby(choice, username, userRating);
                            getToLobby();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent)),
                          child: const Text(
                            "1 Day",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
