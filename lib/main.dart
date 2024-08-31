import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/pages/auth.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';
import 'package:sound_cloud_clone/services/auth_local.dart';
import 'package:sound_cloud_clone/themes/theme.dart';
import 'package:sound_cloud_clone/utils/main_nav_page.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await UserPreferences.clearUser();
  User? user = await UserPreferences.getUserData();
  runApp(
    ProviderScope(
      overrides: [
        userProvider.overrideWith((ref) => UserNotifier(ref)..setUser(user)),
      ],
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
    final user = ref.read(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeCustom,
      routes: {
        AuthPage.routeName: (context) => const AuthPage(),
        MainNavPage.routeName: (context) => const MainNavPage(),
      },
      home: user == null ? const AuthPage() : const MainNavPage(),
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
