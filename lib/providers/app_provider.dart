import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int _currentTab = 0;

  int get currentTab => _currentTab;

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void scrollToTop(int index, List<ScrollController> scrollControllers) {
    if (_currentTab == index && scrollControllers[index].hasClients) {
      scrollControllers[index].animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    setTab(index);
  }
}

class ScrollControllersProvider extends ChangeNotifier {
  final List<ScrollController> _scrollControllers =
      List.generate(5, (_) => ScrollController());

  List<ScrollController> get scrollControllers => _scrollControllers;
}

class BackgroundProvider extends ChangeNotifier {
  bool _showBackground = false;

  bool get showBackground => _showBackground;

  void setBackground(bool value) {
    _showBackground = value;
    notifyListeners();
  }
}
