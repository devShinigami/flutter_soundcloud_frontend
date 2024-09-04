import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/track_card.dart';
import 'package:sound_cloud_clone/components/user_srch_card.dart';
import 'package:sound_cloud_clone/models/search.dart';

class AllSearch extends StatelessWidget {
  final SearchModel searchModel;
  const AllSearch({
    super.key,
    required this.searchModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tracks',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: searchModel.tracks.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TrackCard(
                track: searchModel.tracks[index],
              );
            },
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: searchModel.users.length,
              itemBuilder: (context, index) {
                return UserSearchCard(
                  user: searchModel.users[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
