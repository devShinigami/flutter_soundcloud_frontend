import 'package:flutter/material.dart';

class GradientBackground extends StatefulWidget {
  final List<Alignment> alignments;
  final bool isLogin;
  final List<Color> colors;
  const GradientBackground({
    super.key,
    required this.alignments,
    required this.colors,
    required this.isLogin,
  });

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _beginAlignment;
  late Animation<AlignmentGeometry> _endAlignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _endAlignment = AlignmentTween(
      begin: widget.alignments[0],
      end: widget.alignments[1],
    ).animate(_controller);
    _beginAlignment = AlignmentTween(
      begin: Alignment.bottomRight,
      end: widget.alignments[1],
    ).animate(_controller);
    // _updateAlignments();
  }

  @override
  void didUpdateWidget(GradientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLogin != oldWidget.isLogin) {
      _updateAlignments();
      _controller.forward(from: 0.0);
    }
  }

  void _updateAlignments() {
    _beginAlignment = TweenSequence<AlignmentGeometry>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: AlignmentTween(
            begin: widget.isLogin ? Alignment.topRight : Alignment.topLeft,
            end: widget.isLogin ? Alignment.topLeft : Alignment.topRight,
          ),
        ),
      ],
    )
        .chain(
          CurveTween(curve: Curves.easeIn),
        )
        .animate(_controller);

    _endAlignment = TweenSequence<AlignmentGeometry>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: AlignmentTween(
            begin:
                widget.isLogin ? Alignment.bottomLeft : Alignment.bottomRight,
            end: widget.isLogin ? Alignment.bottomRight : Alignment.bottomLeft,
          ),
        ),
      ],
    )
        .chain(
          CurveTween(curve: Curves.easeIn),
        )
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: _beginAlignment.value,
              end: _endAlignment.value,
              colors: widget.colors,
            ),
          ),
        );
      },
    );
  }
}
