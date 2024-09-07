import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/container.dart';
import 'package:sound_cloud_clone/components/liked_textfield.dart';
import 'package:sound_cloud_clone/components/liked_track_list.dart';
import 'package:sound_cloud_clone/components/sliver_gradient.dart';
import 'package:sound_cloud_clone/providers/track_provider.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';

class LikedTracks extends ConsumerStatefulWidget {
  const LikedTracks({super.key});

  @override
  ConsumerState<LikedTracks> createState() => _LikedTracksState();
}

class _LikedTracksState extends ConsumerState<LikedTracks> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(userProvider)!.id;
    final likedTracksAsyncValue = ref.watch(likedTracksProvider(userId));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        isUsedAsSliver: true,
        controller: controller,
        title: const LikedTrackSearchField(
          fillColor: Colors.transparent,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: MyContainer(
              scrollController: controller,
              child: const SliverGradient(),
            ),
          ),
          likedTracksAsyncValue.when(
            data: (tracks) => const LikedTrackList(
              tracks: [],
            ),
            error: (err, stackTrace) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    err.toString(),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
