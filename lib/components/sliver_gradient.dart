import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';

class SliverGradient extends StatelessWidget {
  const SliverGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Center(
          child: GradientAnimationText(
            text: Text(
              'S O U N D C L O U D',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            colors: <Color>[
              Theme.of(context).colorScheme.tertiary.withAlpha(100),
              Theme.of(context).colorScheme.tertiary.withOpacity(1),
            ],
            duration: const Duration(seconds: 3),
            transform: const GradientRotation(20),
          ),
        ),
      ],
    );
  }
}
