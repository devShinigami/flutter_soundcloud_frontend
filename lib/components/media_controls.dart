import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';

class MediaControls extends ConsumerStatefulWidget {
  const MediaControls({super.key});

  @override
  ConsumerState<MediaControls> createState() => _MediaControlsState();
}

class _MediaControlsState extends ConsumerState<MediaControls> {
  double containerHeight = 70.0;
  late double _expandedHeight;
  final double _dragThresholdHeight = 20.0;
  final double _collapsedHeight = 70.0;
  double _dragDistance = 0.0;
  late double _middle;
  EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 12);

  void dragged() {
    if (containerHeight == _collapsedHeight) {
      setState(() {
        containerHeight = _expandedHeight;
        _padding = EdgeInsets.zero;
      });
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(
      () {
        _padding = EdgeInsets.zero;
        containerHeight -= details.delta.dy;
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
      if (_dragDistance.abs() > _dragThresholdHeight) {
        containerHeight = _expandedHeight;
      } else {
        if (details.primaryVelocity! < 0) {
          containerHeight = _expandedHeight;
        } else if (details.primaryVelocity! > 0) {
          containerHeight = _collapsedHeight;
        }
      }
      if (containerHeight < _middle) {
        containerHeight = _collapsedHeight;
        _padding = const EdgeInsets.symmetric(horizontal: 12);
      }
      if (containerHeight > _middle) {
        containerHeight = _expandedHeight;
      }
      _dragDistance = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundToggle = ref.watch(backgroundProvider.notifier);
    _expandedHeight =
        (MediaQuery.of(context).size.height - 30) - kToolbarHeight;
    _middle = _expandedHeight / 2;
    return GestureDetector(
      onVerticalDragCancel: () {
        setState(() {
          containerHeight = _collapsedHeight;
        });
      },
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
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: containerHeight,
              padding: const EdgeInsets.all(
                14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondary, width: 1.2),
                color: Theme.of(context).primaryColor.withAlpha(200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.pause, color: Colors.orange),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('VASTO LORDE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text('Eternal Raijin',
                          style: TextStyle(color: Colors.orange, fontSize: 12)),
                    ],
                  ),

                  // SizedBox(width: 12),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
