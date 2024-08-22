import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabProvider = StateNotifierProvider<TabNotifier, int>((ref) {
  return TabNotifier();
});

class TabNotifier extends StateNotifier<int> {
  TabNotifier() : super(0);

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

final scrollControllersProvider = Provider<List<ScrollController>>((ref) {
  return List.generate(5, (_) => ScrollController());
});

final backgroundProvider =
    StateNotifierProvider<BackgroundNotifier, bool>((ref) {
  return BackgroundNotifier();
});

class BackgroundNotifier extends StateNotifier<bool> {
  BackgroundNotifier() : super(false);

  void setBackground(bool value) {
    state = value;
  }
}
