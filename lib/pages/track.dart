import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/providers/current_track_provider.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({
    super.key,
  });

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView.builder(
          controller: _pageController,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                });
              },
              child: TrackItem(
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}

class TrackItem extends ConsumerStatefulWidget {
  final int index;
  const TrackItem({
    super.key,
    required this.index,
  });

  @override
  ConsumerState<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends ConsumerState<TrackItem> {
  bool isStopped = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTrack = ref.watch(currentTrackProvider);
    final trackNotifier = ref.read(currentTrackProvider.notifier);
    return StreamBuilder(
      stream: trackNotifier.audioPlayer?.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = trackNotifier.audioPlayer?.duration ?? Duration.zero;
        double progress = duration.inMilliseconds > 0
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            final maxScroll = _scrollController.position.maxScrollExtent;
            _scrollController.animateTo(
              progress * maxScroll,
              duration: const Duration(milliseconds: 50),
              curve: Curves.linear,
            );
          }
        });
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (snapshot.hasData) {
          return Stack(
            children: [
              OverflowBox(
                maxHeight: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Image(
                              image: NetworkImage(currentTrack!.trackImage.url),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (!trackNotifier.isPlaying)
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 50,
                    sigmaY: 50,
                  ),
                  child: Container(
                    color: Theme.of(context).primaryColor.withAlpha(200),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    trackNotifier.playPause();
                  });
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.transparent,
                  height: 120,
                  width: MediaQuery.of(context).size.width - 32,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentTrack.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      backgroundColor: trackNotifier.isPlaying
                                          ? Colors.black
                                          : null,
                                    ),
                              ),
                              Text(
                                currentTrack.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      backgroundColor: trackNotifier.isPlaying
                                          ? Colors.black
                                          : null,
                                    ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_downward),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(200),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 80,
                    width: MediaQuery.of(context).size.width - 32,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Slider(
                            activeColor: Theme.of(context).colorScheme.tertiary,
                            inactiveColor:
                                Theme.of(context).colorScheme.secondary,
                            min: 0,
                            max: 1,
                            value: progress,
                            onChanged: (val) {
                              progress = val;
                              trackNotifier.seek(val);
                            },
                            onChangeStart: (val) {
                              trackNotifier.wasPlayingBeforeChange =
                                  trackNotifier.isPlaying;
                              if (trackNotifier.isPlaying) {
                                trackNotifier.playPause();
                              }
                            },
                            onChangeEnd: (val) {
                              if (trackNotifier.wasPlayingBeforeChange) {
                                trackNotifier.playPause();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
