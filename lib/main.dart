import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/pages/auth.dart';
import 'package:sound_cloud_clone/themes/theme.dart';
import 'package:sound_cloud_clone/utils/main_nav_page.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ToastificationWrapper(
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeCustom,
      routes: {
        AuthPage.routeName: (context) => const AuthPage(),
        MainNavPage.routeName: (context) => const MainNavPage(),
      },
      home: const AuthPage(),
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
