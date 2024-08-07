import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final List<Alignment> alignments;
  final List<Color> colors;
  const GradientBackground({
    super.key,
    required this.alignments,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: alignments[0],
          end: alignments[1],
          colors: colors,
        ),
      ),
    );
  }
}
