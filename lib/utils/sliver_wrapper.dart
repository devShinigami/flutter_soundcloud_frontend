import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/sliver_appbar_delegate.dart';

class SliverWrapper extends StatefulWidget {
  final ScrollController scrollController;
  final Widget headerChild;
  final Widget background;
  final Widget adapterChild;
  const SliverWrapper({
    super.key,
    required this.scrollController,
    required this.background,
    required this.adapterChild,
    required this.headerChild,
  });

  @override
  State<SliverWrapper> createState() => _SliverWrapperState();
}

class _SliverWrapperState extends State<SliverWrapper>
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
  }

  void _scrollListener() {
    double opacity = 1 - (widget.scrollController.offset / 100);
    if (opacity < 0) opacity = 0;
    if (opacity > 1) opacity = 1;
    _animationController.value = opacity;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                background: widget.background,
                minHeight: 80,
                animationController: _animationController,
                maxHeight: 200,
                child: widget.headerChild,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: widget.adapterChild,
            )
          ],
        )
      ],
    );
  }
}
