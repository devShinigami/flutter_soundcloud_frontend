import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String txt;
  final void Function() onTap;
  final Color color;
  const MyButton({
    super.key,
    required this.onTap,
    required this.txt,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 12),
        // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Button padding
        elevation: 5, // Shadow elevation
      ),
      child: Text(
        txt,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
