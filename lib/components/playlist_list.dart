import 'package:flutter/material.dart';

class PlaylistList extends StatelessWidget {
  final ScrollController controller;
  const PlaylistList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: controller,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      'https://th.bing.com/th/id/R.f98c1b8db5a81efe2d9e16872bf07e07?rik=MHIrfnAOGGV64g&riu=http%3a%2f%2fimg3.wikia.nocookie.net%2f__cb20140802183800%2ffear-world%2fimages%2f2%2f28%2fMadara_Uchiha.png&ehk=AKZ3DpXh1bSdiOGh8w1le3E0Z9tWxhJEYTQqO5oS8BI%3d&risl=&pid=ImgRaw&r=0',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Madara uchiha',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'shinigami',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text(
                          'Private • 6 tracks • 12:52',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Colors.white),
                ],
              ),
            );
          }),
    );
  }
}
