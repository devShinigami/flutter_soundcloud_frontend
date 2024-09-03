import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/models/track.dart';
import 'package:sound_cloud_clone/providers/current_track_provider.dart';
import 'package:lottie/lottie.dart';

class TrackCard extends ConsumerStatefulWidget {
  final Track track;
  const TrackCard({
    super.key,
    required this.track,
  });

  @override
  ConsumerState<TrackCard> createState() => _TrackCardState();
}

class _TrackCardState extends ConsumerState<TrackCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTrack = ref.watch(currentTrackProvider);
    final trackNotifier = ref.read(currentTrackProvider.notifier);
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        ref.read(currentTrackProvider.notifier).updateTrack(widget.track);
      },
      child: Ink(
        child: SizedBox(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      widget.track.trackImage.url,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                    if (currentTrack?.id == widget.track.id)
                      Positioned(
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: trackNotifier.isPlaying ? 0 : -15,
                      left: 0,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: trackNotifier.isPlaying
                            ? Lottie.asset(
                                'assets/animation/play.json',
                                height: 60,
                                width: 60,
                                controller: _controller,
                              )
                            : SvgPicture.asset(
                                'assets/icons/stop_dots.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.tertiary,
                                  BlendMode.srcIn,
                                ),
                                height: 60,
                                width: 60,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.track.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.track.user.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/arrow.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn,
                        ),
                        height: 18,
                      ),
                      Text(
                        widget.track.timesOfPlayed.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13),
                      ),
                      const Gap(5),
                      Text(
                        '${widget.track.duration.inMinutes.toString()}:${(widget.track.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 13,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
