import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/cinematic.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextTheme2('Choose Your Game: '),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (null),
                  child: Text(
                    "5|5",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
              VerticalDivider(
                thickness: 1,
                color: Color.fromARGB(255, 248, 203, 68),
                width: 50,
              ),
              TextButton(
                  onPressed: (null),
                  child: Text("10|5",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 248, 203, 68),
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (null),
                  child: Text("10|0",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              VerticalDivider(
                thickness: 1,
                color: Color.fromARGB(255, 248, 203, 68),
                width: 50,
              ),
              TextButton(
                  onPressed: (null),
                  child: Text("15|5",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 248, 203, 68),
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (null),
                  child: Text("15|0",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              VerticalDivider(
                thickness: 0.5,
                color: Color.fromARGB(255, 248, 203, 68),
                width: 50,
              ),
              TextButton(
                  onPressed: (null),
                  child: Text("30|0",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 248, 203, 68),
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (null),
                  child: Text("1 hr",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              VerticalDivider(
                thickness: 0.5,
                color: Color.fromARGB(255, 248, 203, 68),
                width: 50,
              ),
              TextButton(
                  onPressed: (null),
                  child: Text("1 day",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }
}
