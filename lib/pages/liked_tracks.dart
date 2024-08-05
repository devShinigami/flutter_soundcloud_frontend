import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/sliver_gradient.dart';
import 'package:sound_cloud_clone/utils/sliver_wrapper.dart';

class LikedTracks extends StatelessWidget {
  const LikedTracks({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(isUsedAsSliver: true, controller: controller, title: ""),
      backgroundColor: Theme.of(context).primaryColor,
      body: SliverWrapper(
        scrollController: controller,
        background: const SliverGradient(),
        headerChild: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Your likes',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 28),
            ),
          ),
        ),
        adapterChild: Container(
          height: 1000,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
