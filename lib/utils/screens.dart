import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/main.dart';
import 'package:sound_cloud_clone/pages/feed.dart';
import 'package:sound_cloud_clone/pages/home.dart';
import 'package:sound_cloud_clone/pages/library.dart';
import 'package:sound_cloud_clone/pages/search.dart';

List<Widget> getScreens(List<ScrollController> scrollControllers) {
  final List<Widget> screens = [
    HomePage(controller: scrollControllers[0]),
    const Feed(),
    const Search(),
    LibraryPage(controller: scrollControllers[3]),
    UpgradeScreen(),
  ];
  return screens;
}
