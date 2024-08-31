import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/track_card.dart';

class LikedTrackList extends StatelessWidget {
  const LikedTrackList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(),
          );
        },
        childCount: 10,
      ),
    );
  }
}
