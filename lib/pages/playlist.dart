import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/playlist_list.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        isUsedAsSliver: false,
        controller: controller,
        title: Text(
          'Playlist',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: const [],
      ),
      body: Column(
        children: [
          PlaylistList(controller: controller),
          const Gap(120),
        ],
      ),
    );
  }
}
