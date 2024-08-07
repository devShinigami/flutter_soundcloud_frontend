import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabController extends StateNotifier<int> {
  TabController() : super(0);
  void setTab(int index) {
    state = index;
  }

  void scrollToTop(int index, List<ScrollController> scrollControllers) {
    if (state == index && scrollControllers[index].hasClients) {
      scrollControllers[index].animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    setTab(index);
  }
}

final tabProvider = StateNotifierProvider<TabController, int>((ref) {
  return TabController();
});

final scrollControllersProvider = Provider((ref) {
  return List.generate(5, (_) => ScrollController());
});

class BackgroundContainer extends StateNotifier<bool> {
  BackgroundContainer() : super(false);
  void setBackground(bool value) {
    state = value;
  }
}

final backgroundProvider =
    StateNotifierProvider<BackgroundContainer, bool>((ref) {
  return BackgroundContainer();
});
