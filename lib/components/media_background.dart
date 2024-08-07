import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/gradient_background.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';

class MediaBackground extends ConsumerWidget {
  const MediaBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isbackground = ref.watch(backgroundProvider);
    final toggleBackground = ref.watch(backgroundProvider.notifier);
    return Stack(
      children: [
        Visibility(
          visible: isbackground,
          child: GestureDetector(
            onTap: () {
              toggleBackground.setBackground(false);
            },
            child: GradientBackground(
              alignments: const [
                Alignment.topCenter,
                Alignment.bottomCenter,
              ],
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
                Colors.black,
              ],
            ),
          ),
        ),
        Visibility(
          visible: isbackground,
          child: Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 4),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
