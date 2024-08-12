import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/custom_box.dart';
import 'package:sound_cloud_clone/components/gradient_background.dart';
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
                print(err);
              },
              loading: () {},
            ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Stack(
                children: [
                  GradientBackground(
                    alignments: const [
                      Alignment.centerLeft,
                      Alignment.centerRight,
                    ],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.9),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBox(
                          onTap: () async {
                            await ref
                                .read(userViewModelProvider.notifier)
                                .signUp(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                          },
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          isLogin: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Create your account and start listening to music",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
