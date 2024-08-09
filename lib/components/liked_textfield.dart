import 'package:flutter/material.dart';

class LikedTrackSearchField extends StatelessWidget {
  const LikedTrackSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 6,
          ),
          fillColor: Colors.transparent,
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.bodySmall,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
