import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/custom_bottom_nav.dart';
import 'package:sound_cloud_clone/components/media_background.dart';
import 'package:sound_cloud_clone/components/media_controls.dart';

class MainNavPage extends StatefulWidget {
  final Widget child;
  final bool showMediaControls;
  const MainNavPage({
    super.key,
    required this.showMediaControls,
    required this.child,
  });

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Visibility(
                  visible: widget.showMediaControls,
                  child: const MediaControls(),
                ),
                const CustomBottomNav()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
