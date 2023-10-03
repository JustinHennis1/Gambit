import 'package:flutter/material.dart';

class LogoBox extends StatelessWidget {
  final String imagePath;
  const LogoBox({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(125, 101, 87, 14), width: 3),
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Image.asset(
        imagePath,
        height: 250,
      ),
    );
  }
}
