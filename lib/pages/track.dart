import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({
    super.key,
  });

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  });
                },
                child: TrackItem(
                  pageController: _pageController,
                  index: index,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TrackItem extends StatefulWidget {
  final int index;
  final PageController pageController;
  const TrackItem({
    super.key,
    required this.pageController,
    required this.index,
  });

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  bool isStopped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OverflowBox(
          maxHeight: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Image(
                        image: NetworkImage(
                            'https://i.ytimg.com/vi/J2xY4xB7NC0/hqdefault.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 200,
                  left: 50,
                  child: Text(
                    'Track Item',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isStopped)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        GestureDetector(
          onTap: () {
            setState(() {
              isStopped = !isStopped;
            });
          },
        ),
      ],
    );
  }
}
