import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/sliver_appbar_delegate.dart';

class LikedTracks extends StatefulWidget {
  const LikedTracks({super.key});

  @override
  State<LikedTracks> createState() => _LikedTracksState();
}

class _LikedTracksState extends State<LikedTracks>
    with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 0),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double opacity = 1 - (_controller.position.pixels / 50);
    if (opacity < 0) opacity = 0;
    if (opacity > 1) opacity = 1;
    animationController.value = opacity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          MyAppBar(isUsedAsSliver: true, controller: _controller, title: ""),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  animationController: animationController,
                  minHeight: 80,
                  maxHeight: 200.0,
                  child: const Text('Your Likes'),
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1000,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
