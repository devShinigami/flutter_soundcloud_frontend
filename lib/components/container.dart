import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  const MyContainer(
      {super.key, required this.scrollController, required this.child});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 0),
    );
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose();
    _animationController.dispose();
  }

  void _scrollListener() {
    double opacity = 1 - (widget.scrollController.offset / 100);
    if (opacity < 0) opacity = 0;
    if (opacity > 1) opacity = 1;
    _animationController.value = opacity;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: SizedBox(
        height: 250,
        child: widget.child,
      ),
    );
  }
}
