import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/container.dart';
import 'package:sound_cloud_clone/components/liked_textfield.dart';
import 'package:sound_cloud_clone/components/liked_track_list.dart';
import 'package:sound_cloud_clone/components/sliver_gradient.dart';

class LikedTracks extends StatefulWidget {
  const LikedTracks({super.key});

  @override
  State<LikedTracks> createState() => _LikedTracksState();
}

class _LikedTracksState extends State<LikedTracks> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        isUsedAsSliver: true,
        controller: controller,
        title: const LikedTrackSearchField(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: MyContainer(
              scrollController: controller,
              child: const SliverGradient(),
            ),
          ),
          const LikedTrackList(),
        ],
      ),
    );
  }
}
