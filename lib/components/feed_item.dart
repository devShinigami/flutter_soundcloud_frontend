import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/feed_item_info.dart';
import 'package:sound_cloud_clone/utils/flow_delegate.dart';

class FeedItem extends StatelessWidget {
  final PageController pageController;
  final int index;
  const FeedItem({
    super.key,
    required this.pageController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.8,
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Flow(
              delegate: ParallaxFlowDelegate(
                  index: index, pageController: pageController),
              children: [
                Image.network(
                  'https://i.pinimg.com/originals/74/b6/66/74b6663483c39faa4599982a3f7dbde4.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const Positioned(
              bottom: 200,
              right: 16,
              child: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  Text('6336'),
                  SizedBox(height: 16),
                  Icon(
                    Icons.comment,
                    color: Colors.white,
                  ),
                  Text('12'),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FeedItemInfo(),
            )
          ],
        ),
      ),
    );
  }
}
