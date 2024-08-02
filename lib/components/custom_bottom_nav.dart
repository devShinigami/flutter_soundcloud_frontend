import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
        child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            enableFeedback: false,
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home2.svg',
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
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/upload.svg',
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
            onTap: onTap),
      ),
    );
  }
}
