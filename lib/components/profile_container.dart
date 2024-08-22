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
        user.bannerPic.url.isEmpty
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
                backgroundImage: user.profilePic.url.isEmpty
                    ? NetworkImage(user.profilePic.url)
                    : const AssetImage('/assets/images/default_user_pic.png'),
                radius: 42,
              ),
              const Gap(20),
              Text(user.name, style: Theme.of(context).textTheme.displayMedium),
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
