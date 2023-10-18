import 'package:flutter/material.dart';
import 'package:gambit/pages/games_page.dart';
import 'package:gambit/pages/texttheme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/back3.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextTheme1('Welcome to Gambit!'),
          const SizedBox(
            height: 100,
          ), // Add some spacing between text and leaderboard
          _page(context),
        ],
      ),
    );
  }

  Widget _page(BuildContext context) {
    dynamic color1 = Colors.white;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.amber.shade700.withOpacity(0.25),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.black, // Set your desired border color here
              width: 2.0, // Set the border width
            ),
            borderRadius: BorderRadius.circular(8.0), // Set the border radius
          ),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Friends: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Young_Serif',
                      ),
                      textScaleFactor: 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 50),
                    child: Text(
                      'online: 0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Young_Serif',
                      ),
                      textScaleFactor: 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 50),
                    child: Text(
                      'offline: 0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Young_Serif',
                      ),
                      textScaleFactor: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 200,
        ),
        TextButton(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 50)),
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.amber.shade700.withOpacity(0.45)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GamePage()));
          },
          child: Text(
            'Play',
            style: TextStyle(
              color: color1,
              fontSize: 20,
              fontFamily: 'Young_Serif',
            ),
            textScaleFactor: 2,
          ),
        ),
      ],
    );
  }
}
