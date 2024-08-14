import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_box.dart';
import 'package:sound_cloud_clone/utils/toast.dart';
import 'package:sound_cloud_clone/view/user_viewmodel.dart';

class LoginForm extends ConsumerStatefulWidget {
  final bool isLogin;
  final void Function() toggle;
  const LoginForm({
    super.key,
    required this.isLogin,
    required this.toggle,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      getToast('Please fill all fields');
      return;
    }
    await ref.read(userViewModelProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        userViewModelProvider,
        (previous, next) => next.when(
              data: (data) {
                Navigator.popAndPushNamed(context, '/main_nav_page');
              },
              error: (err, stackTrace) {
                getToast(err.toString());
              },
              loading: () {},
            ));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.displayLarge,
                  children: [
                    const TextSpan(
                      text: "Discover and share the ",
                    ),
                    TextSpan(
                        text: "sounds",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary)),
                    const TextSpan(text: " you love")
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Text(
              "Soundcloud is the world's leading audio platform, allowing people to discover and share the sounds they love",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          CustomBox(
            onTap: submit,
            emailController: _emailController,
            passwordController: _passwordController,
            isLogin: widget.isLogin,
            toggle: () {
              setState(() {
                widget.toggle();
                _emailController.text = "";
                _passwordController.text = "";
              });
            },
          )
        ],
      ),
    );
  }
}
