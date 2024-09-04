import 'package:flutter/material.dart';

Widget buildHighlightedText({
  required BuildContext context,
  required String fullText,
  required String query,
}) {
  if (query.isEmpty) {
    return Text(fullText);
  }

  final spans = <TextSpan>[];
  int start = 0;

  while (start < fullText.length) {
    final index = fullText.toLowerCase().indexOf(query.toLowerCase(), start);

    if (index == -1) {
      spans.add(
        TextSpan(
          text: fullText.substring(start),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      );
      break;
    }

    if (index > start) {
      spans.add(TextSpan(text: fullText.substring(start, index)));
    }
    spans.add(
      TextSpan(
        text: fullText.substring(index, index + query.length),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    start = index + query.length;
  }

  return RichText(
    text: TextSpan(
      children: spans,
    ),
  );
}
