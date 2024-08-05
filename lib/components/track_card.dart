import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TrackCard extends StatelessWidget {
  final int index;
  const TrackCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://th.bing.com/th/id/R.f98c1b8db5a81efe2d9e16872bf07e07?rik=MHIrfnAOGGV64g&riu=http%3a%2f%2fimg3.wikia.nocookie.net%2f__cb20140802183800%2ffear-world%2fimages%2f2%2f28%2fMadara_Uchiha.png&ehk=AKZ3DpXh1bSdiOGh8w1le3E0Z9tWxhJEYTQqO5oS8BI%3d&risl=&pid=ImgRaw&r=0',
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pasetas (Prod. Riles)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Madara Uchiha',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              print('More $index');
            },
          )
        ],
      ),
    );
  }
}
