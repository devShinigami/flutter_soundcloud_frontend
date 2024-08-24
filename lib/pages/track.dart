import 'package:flutter/material.dart';

class TrackScreen extends StatefulWidget {
  final double height;
  const TrackScreen({
    super.key,
    required this.height,
  });

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      children: [
        OverflowBox(
          maxHeight: h,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: 700,
                  child: Image(
                    image: NetworkImage(
                        'https://i.ytimg.com/vi/0OX4qFWrUXQ/maxresdefault.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Track Screen',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
        OverflowBox(
          maxHeight: h,
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: SizedBox(
                  width: 700,
                  child: Image(
                    image: NetworkImage(
                        'https://i.ytimg.com/vi/0OX4qFWrUXQ/maxresdefault.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Track Screen',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
