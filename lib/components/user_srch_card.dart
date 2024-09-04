import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/models/search_user.dart';

class UserSearchCard extends StatelessWidget {
  final SearchUser user;
  const UserSearchCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profilePic.url),
          radius: 48,
        ),
        Text(
          user.name,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 1,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'follow',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}
