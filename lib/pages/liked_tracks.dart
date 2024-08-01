import 'package:flutter/material.dart';

class LikedTracks extends StatelessWidget {
  const LikedTracks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text("Liked Tracks"),
      ),
    );
  }
}
