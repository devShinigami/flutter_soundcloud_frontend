import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/pages/track.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';
import 'package:sound_cloud_clone/providers/current_track_provider.dart';

class MediaControls extends ConsumerStatefulWidget {
  const MediaControls({super.key});

  @override
  ConsumerState<MediaControls> createState() => _MediaControlsState();
}

class _MediaControlsState extends ConsumerState<MediaControls> {
  double containerHeight = 70.0;
  late double _expandedHeight;
  final double _collapsedHeight = 70.0;
  late double _middle;
  EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 12);
  late double oneThird;
  double opacity = 0.0;

  void dragged() {
    if (containerHeight == _collapsedHeight) {
      setState(
        () {
          containerHeight = _expandedHeight;
          _padding = EdgeInsets.zero;
          opacity = 1.0;
        },
      );
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(
      () {
        _padding = EdgeInsets.zero;
        containerHeight -= details.delta.dy;
        containerHeight > (oneThird + 20) ? opacity = 1.0 : opacity = 0.0;
        if (containerHeight < _collapsedHeight) {
          containerHeight = _collapsedHeight;
        } else if (containerHeight > _expandedHeight) {
          containerHeight = _expandedHeight;
        }
      },
    );
  }

  void onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if (details.primaryVelocity! < 0) {
        containerHeight = _expandedHeight;
      } else if (details.primaryVelocity! > 0) {
        containerHeight = _collapsedHeight;
        opacity = 0.0;
      }

      if (containerHeight < _middle) {
        _padding = const EdgeInsets.symmetric(horizontal: 12);
        containerHeight = _collapsedHeight;
        opacity = 0.0;
      }
      if (containerHeight > _middle) {
        opacity = 1.0;
        containerHeight = _expandedHeight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTrack = ref.watch(currentTrackProvider);
    final trackNotifier = ref.watch(currentTrackProvider.notifier);
    final backgroundToggle = ref.watch(backgroundProvider.notifier);
    _expandedHeight =
        (MediaQuery.of(context).size.height - 30) - kToolbarHeight;
    _middle = _expandedHeight / 2;
    oneThird = _expandedHeight / 5;
    return currentTrack == null
        ? Container()
        : GestureDetector(
            onTap: () => dragged(),
            onLongPress: () {
              backgroundToggle.setBackground(true);
            },
            onVerticalDragUpdate: (details) => onVerticalDragUpdate(details),
            onVerticalDragEnd: (details) => onVerticalDragEnd(details),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 100),
              padding: _padding,
              child: ClipRRect(
                borderRadius: containerHeight == _collapsedHeight
                    ? const BorderRadius.all(
                        Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: containerHeight,
                    padding: getTrueOrFalse()
                        ? null
                        : const EdgeInsets.all(
                            14,
                          ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: getTrueOrFalse()
                          ? null
                          : Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.2,
                            ),
                      color: Theme.of(context).primaryColor.withAlpha(200),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: opacity == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    trackNotifier.playPause();
                                  },
                                  icon: trackNotifier.isPlaying
                                      ? Icon(
                                          Icons.pause,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        )
                                      : Icon(Icons.play_arrow,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(currentTrack.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      currentTrack.user.name,
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/cast.svg',
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.secondary,
                                      BlendMode.srcIn),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.favorite, color: Colors.red),
                              ],
                            )
                          : const TrackScreen(),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  bool getTrueOrFalse() {
    return containerHeight > oneThird;
  }
}
