import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/providers/app_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentTab = Provider.of<TabProvider>(context).currentTab;
    final tabContoller = Provider.of<TabProvider>(context);
    final scrollControllers =
        Provider.of<ScrollControllersProvider>(context).scrollControllers;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              BottomNavigationBar(
                  elevation: 0,
                  backgroundColor:
                      Theme.of(context).primaryColor.withAlpha(200),
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
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                bottom: 0,
                left: currentTab * (MediaQuery.of(context).size.width / 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 7,
                    height: 2,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
