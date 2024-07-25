import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool isHidden;
  const MyTextField({super.key, required this.hint, required this.isHidden});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isHidden,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
    );
  }
}
