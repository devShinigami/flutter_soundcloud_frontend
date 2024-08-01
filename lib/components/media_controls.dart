import 'dart:ui';

import 'package:flutter/material.dart';

class MediaControls extends StatelessWidget {
  const MediaControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.all(
              14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondary, width: 0.8),
              color: Theme.of(context).primaryColor.withAlpha(200),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.pause, color: Colors.orange),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('VASTO LORDE',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Eternal Raijin',
                        style: TextStyle(color: Colors.orange, fontSize: 12)),
                  ],
                ),

                // SizedBox(width: 12),
                Spacer(),
                Icon(Icons.cast, color: Colors.white),
                SizedBox(width: 12),
                Icon(Icons.favorite, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
