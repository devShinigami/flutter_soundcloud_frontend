import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';

class Home extends StatelessWidget {
  final ScrollController controller;
  const Home({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        isUsedAsSliver: false,
        controller: controller,
        title: "Home",
      ),
      body: Scrollbar(
        thickness: 1,
        radius: const Radius.circular(20),
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, right: 16, left: 16, bottom: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "More of what you like",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 1000,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.red.withOpacity(0.4),
                      Colors.redAccent,
                    ]))),
                const Text("End"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
