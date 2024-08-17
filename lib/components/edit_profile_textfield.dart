import 'package:flutter/material.dart';

class EditProfileTextfield extends StatelessWidget {
  final int limit;
  final int remaining;
  final bool canBeEmpty;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String title;

  const EditProfileTextfield({
    super.key,
    required this.canBeEmpty,
    required this.title,
    required this.limit,
    required this.remaining,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            const Spacer(),
            Text(
              remaining == 50
                  ? 'Display name cannot be empty!'
                  : limit.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        SizedBox(
          height: 32,
          child: TextField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            maxLength: 50,
            style: Theme.of(context).textTheme.displayMedium,
            controller: controller,
            decoration: InputDecoration(
              hintText: canBeEmpty ? 'Where are you based?' : '*required',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              counter: const SizedBox(),
            ),
            onChanged: (text) => onChanged!(text),
          ),
        )
      ],
    );
  }
}
