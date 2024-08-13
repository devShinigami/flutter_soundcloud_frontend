import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_box.dart';
import 'package:sound_cloud_clone/components/gradient_background.dart';
import 'package:sound_cloud_clone/components/loader_auth.dart';
import 'package:sound_cloud_clone/utils/toast.dart';
import 'package:sound_cloud_clone/view/user_viewmodel.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userViewModelProvider).isLoading == true;

    ref.listen(
        userViewModelProvider,
        (previous, next) => next.when(
              data: (data) {
                print(data);
              },
              error: (err, stackTrace) {
                getToast(err.toString());
              },
              loading: () {},
            ));

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GradientBackground(
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                        ],
                      ),
                    ),
                  ),
                  CustomBox(
                    onTap: () async {
                      await ref.read(userViewModelProvider.notifier).signUp(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isLogin: false,
                  ),
                ],
              ),
            ),
            if (isLoading) const LoaderAuth(),
          ],
        ),
      ),
    );
  }
}
