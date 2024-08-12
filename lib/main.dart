import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/pages/feed.dart';
import 'package:sound_cloud_clone/pages/home.dart';
import 'package:sound_cloud_clone/pages/library.dart';
import 'package:sound_cloud_clone/pages/login.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';
import 'package:sound_cloud_clone/themes/theme.dart';
import 'package:sound_cloud_clone/utils/main_nav_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  List<Widget> _getScreens(List<ScrollController> scrollControllers) {
    final List<Widget> screens = [
      HomePage(controller: scrollControllers[0]),
      const Feed(),
      SearchScreen(),
      LibraryPage(controller: scrollControllers[3]),
      UpgradeScreen(),
    ];
    return screens;
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(tabProvider);
    final scrollControllers = ref.watch(scrollControllersProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeCustom,
      home: const LoginPage(),

      // MainNavPage(
      //   showMediaControls: currentTab == 1 ? false : true,
      //   child: IndexedStack(
      //     index: currentTab,
      //     children: _getScreens(scrollControllers),
      //   ),
      // ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Screen'));
  }
}

class UpgradeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Upgrade Screen'));
  }
}
