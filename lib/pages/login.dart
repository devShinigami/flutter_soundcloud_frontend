import 'package:flutter/material.dart';
import '../components/gradient_background.dart';
import '../components/custom_box.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            const GradientBackground(),
            SingleChildScrollView(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                          const TextSpan(text: " you love")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      "Soundcloud is the world's leading audio platform, allowing people to discover and share the sounds they love",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const CustomBox(
                    isLogin: true,
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
