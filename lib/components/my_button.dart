import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Text(
            'SIGN IN',
            selectionColor: Colors.white,
            style: TextStyle(
                color: Color.fromARGB(255, 248, 203, 68),
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: 'Times New Roman',
                letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
