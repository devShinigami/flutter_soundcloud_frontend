import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/login_form.dart';
import 'package:sound_cloud_clone/providers/loading_provider.dart';
import '../components/gradient_background.dart';
import '../components/signup_form.dart';
import '../components/loader_auth.dart';

class AuthPage extends ConsumerStatefulWidget {
  static const routeName = '/login';
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool isLogin = true;

  void toggleBetweenLoginAndSignup() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GradientBackground(
              isLogin: isLogin,
              alignments: const [
                Alignment.topLeft,
                Alignment.bottomRight,
              ],
              colors: [
                Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              ],
            ),
            isLogin
                ? LoginForm(
                    isLogin: isLogin,
                    toggle: toggleBetweenLoginAndSignup,
                  )
                : SignupForm(
                    isLogin: isLogin,
                    toggle: toggleBetweenLoginAndSignup,
                  ),
            if (loading) const LoaderAuth(),
          ],
        ),
      ),
    );
  }
}
