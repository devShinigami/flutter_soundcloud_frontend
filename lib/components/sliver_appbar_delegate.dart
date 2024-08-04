import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final AnimationController animationController;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.animationController,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return FadeTransition(
      opacity: animationController,
      child: Stack(
        children: [
          Container(
            height: maxExtent,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Theme.of(context).colorScheme.tertiary,
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
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.tertiary.withAlpha(200),
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                  ],
                  duration: const Duration(seconds: 3))),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Your likes',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 28)),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
