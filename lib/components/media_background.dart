import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';
import 'package:provider/provider.dart';

class MediaBackground extends StatelessWidget {
  const MediaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isbackground =
        Provider.of<BackgroundProvider>(context).showBackground;
    final toggleBackground = Provider.of<BackgroundProvider>(context);
    return Stack(
      children: [
        Visibility(
          visible: isbackground,
          child: GestureDetector(
            onTap: () {
              toggleBackground.setBackground(false);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    Colors.black,
                  ],
                ),
              ),
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
