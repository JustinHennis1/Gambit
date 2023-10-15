import 'package:flutter/material.dart';

class GoogleTile extends StatelessWidget {
  final String imagePath;
  const GoogleTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(124, 211, 180, 24), width: 3),
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Image.asset(
        imagePath,
        height: 75,
      ),
    );
  }
}
