import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/custom_bottom_nav.dart';
import 'package:sound_cloud_clone/components/media_controls.dart';

class MainNavPage extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabTapped;
  const MainNavPage(
      {super.key,
      required this.child,
      required this.currentIndex,
      required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).primaryColor.withAlpha(200),
                  height: 80,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                const MediaControls(),
                CustomBottomNav(onTap: onTabTapped, selectedIndex: currentIndex)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
