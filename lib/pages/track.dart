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
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  });
                },
                child: TrackItem(
                  pageController: _pageController,
                  index: index,
                ),
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
  final PageController pageController;
  const TrackItem({
    super.key,
    required this.pageController,
    required this.index,
  });

  @override
  ConsumerState<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends ConsumerState<TrackItem> {
  bool isStopped = false;

  @override
  Widget build(BuildContext context) {
    final currentTrack = ref.watch(currentTrackProvider);
    final trackNotifier = ref.read(currentTrackProvider.notifier);
    return Stack(
      children: [
        OverflowBox(
          maxHeight: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                Positioned(
                  left: 50,
                  top: 40,
                  child: Text(
                    currentTrack.title,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isStopped)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        GestureDetector(
          onTap: () {
            setState(() {
              isStopped = !isStopped;
            });
          },
        ),
      ],
    );
  }
}
