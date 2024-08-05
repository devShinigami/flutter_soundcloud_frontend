import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/track_card.dart';

class LikedTrackList extends StatelessWidget {
  const LikedTrackList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TrackCard(index: index),
        );
      },
    );
  }
}
