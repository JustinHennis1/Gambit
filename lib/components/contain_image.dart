import 'package:flutter/material.dart';

class ContainImage extends StatelessWidget {
  final String imagePath;
  final double ht;
  const ContainImage({super.key, required this.imagePath, required this.ht});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center, height: ht, child: Image.asset(imagePath));
  }
}
