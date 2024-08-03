import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/sliver_appbar_delegate.dart';

class LikedTracks extends StatefulWidget {
  const LikedTracks({super.key});

  @override
  State<LikedTracks> createState() => _LikedTracksState();
}

class _LikedTracksState extends State<LikedTracks> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
