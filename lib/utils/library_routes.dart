import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/pages/liked_tracks.dart';
import 'package:sound_cloud_clone/pages/playlist.dart';

List<Widget> getRoutes(BuildContext context) {
  final Map<String, dynamic> pages = {
    "Liked Tracks": const LikedTracks(),
    "Playlist": const Playlist(),
    // "Albums": () {},
    // "Following": () {},
  };

  return List.generate(
    pages.length,
    (index) => InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Theme.of(context).colorScheme.secondary,
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                pages.values.elementAt(index),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .animate(animation),
              child: child,
            ),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionDuration: const Duration(milliseconds: 300),
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
