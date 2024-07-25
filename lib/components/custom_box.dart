import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/components/custom_button.dart';
import 'package:sound_cloud_clone/pages/login.dart';
import 'package:sound_cloud_clone/pages/signup.dart';

import 'custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final bool isLogin;
  const CustomBox({super.key, required this.isLogin});

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
                : const MyTextField(
                    hint: "name",
                    isHidden: false,
                  ),

            const SizedBox(height: 20),
            const MyTextField(
              hint: "Email",
              isHidden: false,
            ),
            const SizedBox(height: 20),
            const MyTextField(
              hint: "Password",
              isHidden: true,
            ),
            const SizedBox(height: 20),
            const MyButton(txt: "Sign up"),

            GestureDetector(
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
              child: Text(
                isLogin ? 'Create a new account!' : 'Already user?',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
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
