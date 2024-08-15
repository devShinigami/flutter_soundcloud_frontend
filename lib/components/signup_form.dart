import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_box.dart';
import 'package:sound_cloud_clone/utils/toast.dart';
import 'package:sound_cloud_clone/view/user_viewmodel.dart';

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

  void submit() async {
    if (_nameController.text.isEmpty &&
        _emailController.text.isEmpty &&
        _passwordController.text.isEmpty) {
      getToast('Please fill all fields');
      return;
    }
    await ref.read(userViewModelProvider.notifier).signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userViewModelProvider,
      (previous, next) => next.when(
        data: (data) {
          getToast('Account created successfully!');
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pushNamed(context, '/login');
            },
          );
        },
        error: (err, stackTrace) {
          getToast(err.toString());
        },
        loading: () {},
      ),
    );
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
              setState(() {
                widget.toggle();
                _nameController.text = "";
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
