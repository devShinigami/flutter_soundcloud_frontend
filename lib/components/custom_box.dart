import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/components/custom_button.dart';
import 'custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class CustomBox extends StatelessWidget {
  final bool isLogin;
  final void Function() onTap;
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final void Function() toggle;
  final TextEditingController passwordController;
  const CustomBox({
    super.key,
    required this.isLogin,
    required this.onTap,
    required this.toggle,
    this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          bottom: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
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
                Theme.of(context).colorScheme.tertiary,
                BlendMode.srcIn,
              ),
            ),
            isLogin
                ? Text(
                    "Sign In to free music streaming platform!",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                : Text(
                    "Create your account to get started!",
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
              txt: isLogin ? "Login" : "Sign up",
              color: Theme.of(context).colorScheme.tertiary,
            ),

            Bounce(
              duration: const Duration(milliseconds: 50),
              onPressed: toggle,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: isLogin
                    ? Text("Create a new Account!",
                        style: Theme.of(context).textTheme.bodyMedium)
                    : Text("Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            const SizedBox(height: 20),

            // const Spacer(
            //   flex: 2,
            // )
          ],
        ),
      ),
    );
  }
}
