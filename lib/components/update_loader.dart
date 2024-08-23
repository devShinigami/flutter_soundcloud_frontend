import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UpdateLoader extends StatelessWidget {
  const UpdateLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Theme.of(context).colorScheme.tertiary,
        size: 20,
      ),
    );
  }
}
