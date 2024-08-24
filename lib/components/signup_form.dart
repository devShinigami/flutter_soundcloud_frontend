import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_box.dart';
import 'package:sound_cloud_clone/pages/auth.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';
import 'package:sound_cloud_clone/utils/toast.dart';

class SignupForm extends ConsumerStatefulWidget {
  final bool isLogin;
  final void Function() toggle;
  const SignupForm({
    required this.toggle,
    super.key,
    required this.isLogin,
  });

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      getToast('Please fill all fields');
      return;
    }
    final navigator = Navigator.of(context);
    FocusScope.of(context).unfocus();
    await ref.read(userProvider.notifier).signup(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );

    getToast('Account created successfully!');
    navigator.pushNamed(AuthPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 28),
                children: [
                  const TextSpan(
                    text: "Welcome to ",
                  ),
                  TextSpan(
                      text: "Soundcloud",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary)),
                ],
              ),
            ),
          ),
          CustomBox(
            onTap: submit,
            emailController: _emailController,
            passwordController: _passwordController,
            nameController: _nameController,
            isLogin: widget.isLogin,
            toggle: () {
              setState(
                () {
                  widget.toggle();
                  _nameController.text = "";
                  _emailController.text = "";
                  _passwordController.text = "";
                },
              );
            },
          )
        ],
      ),
    );
  }
}
