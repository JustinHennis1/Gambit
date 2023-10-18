import 'package:flutter/material.dart';

class GoogleTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const GoogleTile({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(124, 211, 180, 24), width: 3),
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Image.asset(
          imagePath,
          height: 75,
        ),
      ),
    );
  }
}
