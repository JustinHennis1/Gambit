import 'package:flutter/material.dart';
import 'package:gambit/components/logouttext.dart';
import 'package:gambit/pages/log_off.dart';
import 'package:gambit/components/texttheme.dart';

class CustomBorderTile extends StatelessWidget {
  const CustomBorderTile(this.destination, this.text1, this.int1, this.icon1,
      {super.key});
  final dynamic destination;
  final String text1;
  final int? int1;
  final IconData? icon1;

  @override
  Widget build(BuildContext context) {
    // if index is not null make sure it is a vlaid index
    if (int1 != null) {
      assert(int1! >= 0 && int1! <= 3);

      // if index is null route to the proper destination page
    } else if (int1 == null) {
      if (icon1! == Icons.logout_rounded) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => destination));
          },
          highlightColor: Colors.white,
          child: Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.amber,
                Colors.red,
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              border: Border.all(
                color: Colors.black, // Set your desired border color here
                width: 5,
              ),
              borderRadius:
                  BorderRadius.circular(20.0), // Set the border radius
            ),
            child: const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: LogOffText()),
                  LogOff(),
                ],
              ),
            ),
          ),
        );
      }

      return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => destination));
        },
        highlightColor: Colors.white,
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.amber.shade700.withOpacity(0.8),

            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.black, // Set your desired border color here
              width: 5, // Set the border width
            ),
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ListTileTheme1(text1)),
                Icon(icon1, color: Colors.black),
              ],
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        DefaultTabController.of(context).animateTo(int1!);
      },
      highlightColor: Colors.white,
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.amber.shade700.withOpacity(0.8),

          border: Border.all(
            color: Colors.black, // Set your desired border color here
            width: 5, // Set the border width
          ),
          borderRadius: BorderRadius.circular(20.0), // Set the border radius
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: ListTileTheme1(text1)),
              Icon(icon1, color: Colors.black87),
            ],
          ),
        ),
      ),
    );
  }
}
