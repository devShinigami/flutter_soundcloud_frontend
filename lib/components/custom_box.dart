import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/components/custom_button.dart';
import 'package:sound_cloud_clone/pages/login.dart';
import 'package:sound_cloud_clone/pages/signup.dart';

import 'custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final bool isLogin;
  final void Function()? onTap;
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const CustomBox({
    super.key,
    required this.isLogin,
    this.onTap,
    this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: isLogin
            ? Border(
                top: BorderSide(color: Theme.of(context).colorScheme.tertiary),
              )
            : Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
        borderRadius: isLogin
            ? const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
            : const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // const Spacer(),
            SvgPicture.asset(
              'assets/icons/soundcloud.svg',
              height: 64,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
            ),
            Text(
              "Sign In to free music streaming platform!",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            isLogin
                ? const SizedBox()
                : MyTextField(
                    controller: nameController!,
                    hint: "name",
                    isHidden: false,
                  ),

            const SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hint: "Email",
              isHidden: false,
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: passwordController,
              hint: "Password",
              isHidden: true,
            ),
            const SizedBox(height: 20),
            MyButton(
              onTap: onTap,
              txt: "Sign up",
              color: Theme.of(context).colorScheme.tertiary,
            ),

            MyButton(
                onTap: () {
                  if (isLogin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signup(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
                txt: isLogin
                    ? "Create a new Account"
                    : "Already have an account?",
                color: Theme.of(context).colorScheme.tertiary),
            const SizedBox(height: 20),
            isLogin
                ? Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 0.5,
                  )
                : const SizedBox(),
            // const Spacer(
            //   flex: 2,
            // )
          ],
        ),
      ),
    );
  }
}
