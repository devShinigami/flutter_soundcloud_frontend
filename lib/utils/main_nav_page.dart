import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_bottom_nav.dart';
import 'package:sound_cloud_clone/components/media_background.dart';
import 'package:sound_cloud_clone/components/media_controls.dart';

class MainNavPage extends ConsumerWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabTapped;
  const MainNavPage(
      {super.key,
      required this.child,
      required this.currentIndex,
      required this.onTabTapped});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withAlpha(200),
                        Theme.of(context).primaryColor.withOpacity(1),
                      ],
                    ),
                    // color: Theme.of(context).primaryColor.withAlpha(200),
                  ),
                ),
              ),
            ),
          ),
          const MediaBackground(),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [MediaControls(), CustomBottomNav()],
            ),
          ),
        ],
      ),
    );
  }
}
