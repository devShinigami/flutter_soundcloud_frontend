import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/feed_item.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FeedItem(
                    pageController: _pageController,
                    index: index,
                  ),
                );
              },
            ),
            Container(
              color: Colors.transparent,
              height: 210,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getButtons(
                    Text(
                      'Discover',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    true,
                  ),
                  const Gap(20),
                  getButtons(
                    Text(
                      'Following',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getButtons(Widget child, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor.withAlpha(200)
            : Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
