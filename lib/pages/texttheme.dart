import 'package:flutter/material.dart';

class TextTheme1 extends StatelessWidget {
  const TextTheme1(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 40, fontFamily: 'Satisfy', color: Colors.white));
  }
}

class TextTheme2 extends StatelessWidget {
  const TextTheme2(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(
      text1,
      style: const TextStyle(
          fontSize: 26, fontFamily: 'Satisfy', color: Colors.white),
    );
  }
}

class TextTheme25 extends StatelessWidget {
  const TextTheme25(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(
      text1,
      style: const TextStyle(
          fontSize: 26, fontFamily: 'Satisfy', color: Colors.red),
    );
  }
}

class TextTheme3 extends StatelessWidget {
  const TextTheme3(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 18, fontFamily: 'Satisfy', color: Colors.white));
  }
}

class TextTheme4 extends StatelessWidget {
  const TextTheme4(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 16, fontFamily: 'Satisfy', color: Colors.white));
  }
}

class TextTheme5 extends StatelessWidget {
  const TextTheme5(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 12, fontFamily: 'Satisfy', color: Colors.white));
  }
}

class ListTileTheme1 extends StatelessWidget {
  const ListTileTheme1(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 20, fontFamily: 'Satisfy', color: Colors.white));
  }
}

class ListTileTheme2 extends StatelessWidget {
  const ListTileTheme2(this.text1, {super.key});
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Text(text1,
        style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Satisfy',
            color: Colors.black,
            fontWeight: FontWeight.bold));
  }
}
