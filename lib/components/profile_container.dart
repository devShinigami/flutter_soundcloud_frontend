import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/models/user_model.dart';

class ProfileContainer extends StatelessWidget {
  final User user;
  const ProfileContainer({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        user.bannerPic.url.isNotEmpty
            ? Image.network(
                user.bannerPic.url,
                height: 100,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
            : const SizedBox(),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: user.profilePic.url.isNotEmpty
                    ? NetworkImage(user.profilePic.url)
                    : const AssetImage('/assets/images/default_user_pic.png'),
                radius: 42,
              ),
              const Gap(20),
              Text(user.name, style: Theme.of(context).textTheme.displayMedium),
              if (user.city.isNotEmpty || user.country.isNotEmpty)
                Row(
                  children: [
                    Text(
                      '${user.city},',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    if (user.city.isNotEmpty) const Gap(10),
                    Text(
                      user.country,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              if (user.city.isEmpty || user.country.isEmpty)
                Text(
                  'Select a city and country',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
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
