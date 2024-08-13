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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Center(
          child: Text(
            txt,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
