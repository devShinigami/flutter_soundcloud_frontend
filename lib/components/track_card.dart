import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/models/track.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  const TrackCard({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              track.trackImage.url,
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
                track.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                track.user.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                    height: 18,
                  ),
                  Text(
                    track.timesOfPlayed.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 13),
                  ),
                  const Gap(5),
                  Text(
                    '${track.duration.inMinutes.toString()}:${(track.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
