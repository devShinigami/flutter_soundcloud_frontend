import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(tabProvider);
    final tabContoller = ref.watch(tabProvider.notifier);
    final scrollControllers = ref.watch(scrollControllersProvider);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              enableFeedback: false,
              currentIndex: currentTab,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/home2.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/homefill.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/feed.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    label: 'Feed'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/search.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/searchfill.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 22,
                    ),
                    label: 'Search'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/upload.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/libraryfill.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    label: 'Library'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/soundcloud.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                      height: 20,
                    ),
                    label: 'Upgrade'),
              ],
              onTap: (index) =>
                  tabContoller.scrollToTop(index, scrollControllers)),
        ),
      ),
    );
  }
}
