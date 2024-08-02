import 'dart:ui';
import 'package:flutter/material.dart';

class MediaControls extends StatefulWidget {
  const MediaControls({super.key});

  @override
  State<MediaControls> createState() => _MediaControlsState();
}

class _MediaControlsState extends State<MediaControls> {
  double containerHeight = 70.0;
  late double _expandedHeight;
  final double _dragThresholdHeight = 20.0;
  final double _collapsedHeight = 70.0;
  double _dragDistance = 0.0;
  late double _middle;

  void dragged() {
    setState(() {
      if (containerHeight == _collapsedHeight) {
        containerHeight = _expandedHeight;
      } else {
        containerHeight = _collapsedHeight;
      }
    });
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(
      () {
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
      }
      if (containerHeight > _middle) {
        containerHeight = _expandedHeight;
      }
      _dragDistance = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      onVerticalDragUpdate: (details) => onVerticalDragUpdate(details),
      onVerticalDragEnd: (details) => onVerticalDragEnd(details),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.pause, color: Colors.orange),
                  SizedBox(width: 12),
                  Column(
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
                  Spacer(),
                  Icon(Icons.cast, color: Colors.white),
                  SizedBox(width: 12),
                  Icon(Icons.favorite, color: Colors.red),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
