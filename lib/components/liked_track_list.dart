import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/models/track.dart';

class LikedTrackList extends StatelessWidget {
  final List<Track> tracks;
  const LikedTrackList({
    super.key,
    required this.tracks,
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
