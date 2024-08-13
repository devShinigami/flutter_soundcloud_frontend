import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderAuth extends StatelessWidget {
  const LoaderAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(200),
          ),
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.tertiary,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
