import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/pages/auth.dart';
import 'package:sound_cloud_clone/providers/current_user_notifier.dart';
import 'package:sound_cloud_clone/themes/theme.dart';
import 'package:sound_cloud_clone/utils/main_nav_page.dart';
import 'package:sound_cloud_clone/view/user_viewmodel.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final notifier = container.read(userViewModelProvider.notifier);
  await notifier.initSharedPreferences();
  final user = await notifier.getUser();
  print(user);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ToastificationWrapper(
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeCustom,
      routes: {
        AuthPage.routeName: (context) => const AuthPage(),
        MainNavPage.routeName: (context) => const MainNavPage(),
      },
      home: currentUser == null ? const AuthPage() : const MainNavPage(),
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
