import 'package:flutter/material.dart';

class ContainImage extends StatelessWidget {
  final String imagePath;
  final double ht;

  const ContainImage({super.key, required this.imagePath, required this.ht});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),  // Adjust the border radius
      child: Image.asset(
        imagePath,
        height: ht,
        fit: BoxFit.cover,
      ),
    );
  }
}