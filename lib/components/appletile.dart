import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(202, 53, 44, 18), width: 4),
          color: const Color.fromARGB(255, 248, 203, 68),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Image.asset(
        imagePath,
        height: 75,
      ),
    );
  }
}
