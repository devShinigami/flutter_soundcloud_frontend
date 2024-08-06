import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/container.dart';
import 'package:sound_cloud_clone/components/liked_track_list.dart';
import 'package:sound_cloud_clone/components/sliver_gradient.dart';

class LikedTracks extends StatelessWidget {
  const LikedTracks({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(isUsedAsSliver: true, controller: controller, title: ''),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyContainer(
              scrollController: controller,
              child: const SliverGradient(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Your likes',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 32),
              ),
            ),
            Container(
              height: 1000,
              color: Theme.of(context).primaryColor,
              child: const LikedTrackList(),
            )
          ],
        ),
      ),
    );
  }
}
