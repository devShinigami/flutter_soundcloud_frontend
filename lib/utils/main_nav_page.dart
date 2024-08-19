import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/custom_bottom_nav.dart';
import 'package:sound_cloud_clone/components/media_background.dart';
import 'package:sound_cloud_clone/components/media_controls.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';
import './screens.dart';
import 'package:provider/provider.dart';

class MainNavPage extends StatefulWidget {
  static const routeName = '/main_nav_page';
  const MainNavPage({
    super.key,
  });

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  @override
  Widget build(BuildContext context) {
    final currentTab = Provider.of<TabProvider>(context).currentTab;
    final scrollControllers =
        Provider.of<ScrollControllersProvider>(context).scrollControllers;
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: currentTab,
            children: getScreens(scrollControllers),
          ),
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
                  visible: currentTab != 1,
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
