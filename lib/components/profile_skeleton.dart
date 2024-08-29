import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Container
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    height: 100,
                  ),
                  Positioned(
                    top: 80,
                    left: 16,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            // Edit Profile Icon
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800],
                ),
              ),
            ),
            // Profile Content
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  for (int i = 0; i < 3; i++)
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.grey[800],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
