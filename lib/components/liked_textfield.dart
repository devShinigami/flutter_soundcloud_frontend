import 'package:flutter/material.dart';

class LikedTrackSearchField extends StatelessWidget {
  final Color fillColor;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  const LikedTrackSearchField({
    super.key,
    this.onChanged,
    this.focusNode,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 6,
          ),
          fillColor: fillColor,
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
