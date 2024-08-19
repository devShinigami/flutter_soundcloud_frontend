import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/loader_auth.dart';
import 'package:sound_cloud_clone/components/login_form.dart';
import '../components/gradient_background.dart';
import '../components/signup_form.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/login';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggleBetweenLoginAndSignup() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            return Stack(
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
                const LoaderAuth(),
              ],
            );
          },
        ),
      ),
    );
  }
}
