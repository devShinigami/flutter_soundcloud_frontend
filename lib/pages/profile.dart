import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/completed_profile.dart';
import 'package:sound_cloud_clone/components/container.dart';
import 'package:sound_cloud_clone/components/bs_edit_profile.dart';
import 'package:sound_cloud_clone/components/profile_container.dart';
import 'package:sound_cloud_clone/components/profile_skeleton.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final userProfileAsyncValue = ref.watch(userProfileFuture(widget.userId));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          isUsedAsSliver: true,
          controller: controller,
          title: const Text(''),
          actions: const [],
        ),
        body: userProfileAsyncValue.when(
          loading: () => const ProfileSkeleton(),
          error: (error, stackTrace) => Text('Error: $error'),
          data: (user) {
            if (user != null) {
              return SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer(
                      scrollController: controller,
                      child: ProfileContainer(user: user),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                showDragHandle: true,
                                context: context,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 50,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                builder: (context) {
                                  return EditProfile(user: user);
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/pencil.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.secondary,
                                BlendMode.srcIn,
                              ),
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      height: 1000,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(15),
                          const CompletedProflieChecks(),
                          const Gap(15),
                          Text(
                            'Top Tracks',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('No user data available');
            }
          },
        ),
      ),
    );
  }
}


// Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         extendBodyBehindAppBar: true,
//         appBar: MyAppBar(
//           isUsedAsSliver: true,
//           controller: controller,
//           title: const Text(''),
//           actions: const [],
//         ),
        // body: 
//       ),