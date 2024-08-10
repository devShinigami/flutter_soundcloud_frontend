import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/pages/liked_tracks.dart';
import 'package:sound_cloud_clone/pages/playlist.dart';

List<Widget> getRoutes(BuildContext context) {
  final Map<String, dynamic> pages = {
    "Liked Tracks": () => const LikedTracks(),
    "Playlist": () => const Playlist(),
    // "Albums": () {},
    // "Following": () {},
  };
  return List.generate(
    pages.length,
    (index) => InkWell(
      highlightColor: Theme.of(context).colorScheme.secondary,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pages[pages.keys.elementAt(index)](),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text(
                pages.keys.elementAt(index),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/arrow.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
