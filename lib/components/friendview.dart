import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'Friends: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Young_Serif',
                  fontWeight: FontWeight.bold,
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
              padding: EdgeInsets.only(right: 100, bottom: 10),
              child: Text(
                'online: 0',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Colors.black54,
                    ),
                  ],
                  color: Colors.white,
                  fontSize: 8,
                  fontFamily: 'Young_Serif',
                  fontWeight: FontWeight.bold,
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
              padding: EdgeInsets.only(right: 100, bottom: 10),
              child: Text(
                'offline: 0',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Colors.black54,
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 165, 0),
                  fontSize: 8,
                  fontFamily: 'Young_Serif',
                ),
                textScaleFactor: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
