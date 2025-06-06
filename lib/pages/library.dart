import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/pages/profile.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';
import 'package:sound_cloud_clone/utils/library_routes.dart';

class LibraryPage extends StatelessWidget {
  final ScrollController controller;
  const LibraryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Library(controller: controller),
        );
      },
    );
  }
}

class Library extends ConsumerStatefulWidget {
  final ScrollController controller;
  const Library({super.key, required this.controller});

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.read(userProvider.select((value) => value!.id));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        controller: widget.controller,
        title: Text(
          'Library',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        isUsedAsSliver: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userId: userId,
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/profile2.svg',
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        thickness: 1,
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, right: 16, left: 16, bottom: 130),
            child: Column(
              children: [
                ...getRoutes(context),
                Container(
                  height: 1000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
