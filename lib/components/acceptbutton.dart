import 'package:flutter/material.dart';

class AcceptButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AcceptButton({super.key, required this.onPressed});

  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  bool isPending = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (isPending) {
              return Colors.grey; // Color when in pending state
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.red; // Color when pressed
            }
            return Colors.green.shade600
                .withOpacity(0.8); // Default amber color
          },
        ),
      ),
      onPressed: isPending ? null : () => _handlePress(),
      child: Text(
        isPending ? 'Pending' : 'Accept',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  void _handlePress() {
    setState(() {
      isPending = true;
    });

    // Call the original onPressed function
    widget.onPressed();
  }
}
