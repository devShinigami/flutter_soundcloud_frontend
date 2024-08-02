import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/pages/liked_tracks.dart';

List<Widget> getRoutes(BuildContext context) {
  final Map<String, dynamic> pages = {
    "Liked Tracks": () => const LikedTracks(),
    // "Playlist": () {},
    // "Albums": () {},
    // "Following": () {},
  };
  return List.generate(
    pages.length,
    (index) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pages[pages.keys.elementAt(index)](),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text(
                pages.keys.elementAt(index),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Theme.of(context).colorScheme.tertiary,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
