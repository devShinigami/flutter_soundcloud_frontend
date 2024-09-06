import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/models/track.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/utils/month_format.dart';

class TrackDetailBottomSheet extends StatelessWidget {
  final Track track;
  const TrackDetailBottomSheet({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(
                      track.trackImage.url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    maxLines: 1,
                    track.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    track.user.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/arrow.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        track.timesOfPlayed.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Gap(10),
                      Text(
                        '${track.duration.inMinutes.toString().padLeft(2, '0')}:${(track.duration.inSeconds % 60).toString().padLeft(2, '0')} ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${track.createdAt.day} ${getMonth(track.createdAt.month)} ${track.createdAt.year}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 0.5,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                  track.user.profilePic.url,
                ),
              ),
              const Gap(10),
              Column(
                children: [
                  Text(
                    track.user.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (track.user.country.isNotEmpty &&
                      track.user.city.isNotEmpty)
                    Text(
                      '${track.user.country}, ${track.user.city}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
