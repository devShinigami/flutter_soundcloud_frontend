import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://th.bing.com/th/id/R.28b96f1c49c31622589fe9ea4b00dc71?rik=%2b48fTHbS88tJjQ&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f19500000%2fTobi-tobi-19529893-1280-720.jpg&ehk=9Sr7gbjRKCuflqYyYB4zHwSMMtFAgQqCmuej9DqkdYs%3d&risl=&pid=ImgRaw&r=0',
          height: 100,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://wallpapercave.com/wp/ZYHYAMM.jpg',
                ),
                radius: 42,
              ),
              const Gap(20),
              Text('Tobi Uchiha',
                  style: Theme.of(context).textTheme.displayMedium),
              Text(
                'ohio, United States',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              const Gap(10),
              Text(
                '17 Followers - 6 Following',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
