import 'package:flutter/material.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  final PageController pageController;
  final int index;

  ParallaxFlowDelegate({
    required this.pageController,
    required this.index,
  }) : super(repaint: pageController);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final double page =
        pageController.hasClients ? pageController.page ?? 0 : 0;
    final double pageOffset = page - index;
    final bool isOnScreen = pageOffset > -1 && pageOffset < 1;

    if (isOnScreen) {
      final double parallax = pageOffset.abs() * context.size.height * 0.1;
      final double opacity = 1.0 - pageOffset.abs();

      final Matrix4 transform = Matrix4.identity()
        ..translate(0.0, context.size.height * pageOffset * 0.3)
        ..translate(0.0, parallax);

      context.paintChild(
        0,
        transform: transform,
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return pageController != oldDelegate.pageController;
  }
}
