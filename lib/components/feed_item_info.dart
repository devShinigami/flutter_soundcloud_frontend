import 'package:flutter/material.dart';

class FeedItemInfo extends StatelessWidget {
  const FeedItemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 120,
        color: Theme.of(context).primaryColor.withAlpha(200),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Car Nachdi - Gippy Grewal and Bohemia',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/74/b6/66/74b6663483c39faa4599982a3f7dbde4.jpg'),
                      ),
                      const SizedBox(width: 8),
                      Text('wanpanman',
                          style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.play_arrow, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
