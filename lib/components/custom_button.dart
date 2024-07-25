import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String txt;
  const MyButton({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
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
