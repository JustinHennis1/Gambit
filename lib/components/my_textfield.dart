import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final Color mycolor;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.mycolor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(
            color: Colors.amber,
            fontFamily: 'Times New Roman',
            decorationColor: Colors.black38),
        enableInteractiveSelection: true,
        maxLength: 254,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        showCursor: true,
        cursorColor: Colors.white,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: mycolor, fontFamily: 'Times New Roman'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black87, width: 50.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
