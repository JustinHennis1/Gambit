import 'package:flutter/material.dart';

class RejectButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RejectButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Reject'),
    );
  }
}
