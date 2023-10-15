import 'package:flutter/material.dart';
import 'package:gambit/components/logouttext.dart';
import 'package:gambit/pages/log_off.dart';
import 'package:gambit/pages/texttheme.dart';

class CustomBorderTile extends StatelessWidget {
  const CustomBorderTile(this.text1, this.int1, this.icon1, {Key? key})
      : super(key: key);

  final String text1;
  final int? int1;
  final IconData? icon1;

  @override
  Widget build(BuildContext context) {
    if (int1 != null) {
      assert(int1! >= 0 && int1! <= 3);
    } else if (int1 == null) {
      if (icon1! == Icons.logout_rounded) {
        return InkWell(
          onTap: () {
            // Add a delay of 300 milliseconds before executing the onTap logic
            Future.delayed(const Duration(milliseconds: 150), () {
              Navigator.pop(context);
            });
          },
          highlightColor: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Set your desired border color here
                width: 2.0, // Set the border width
              ),
              borderRadius: BorderRadius.circular(8.0), // Set the border radius
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
          // Add a delay of 300 milliseconds before executing the onTap logic
          Future.delayed(const Duration(milliseconds: 150), () {
            Navigator.pop(context);
          });
        },
        highlightColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Set your desired border color here
              width: 2.0, // Set the border width
            ),
            borderRadius: BorderRadius.circular(8.0), // Set the border radius
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

    return InkWell(
      onTap: () {
        // Add a delay of 300 milliseconds before executing the onTap logic
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pop(context);
          DefaultTabController.of(context).animateTo(int1!);
        });
      },
      highlightColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Set your desired border color here
            width: 2.0, // Set the border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Set the border radius
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