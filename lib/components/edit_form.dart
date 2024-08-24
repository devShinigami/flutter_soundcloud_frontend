import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/edit_banner_pic.dart';
import 'package:sound_cloud_clone/components/edit_circle_avatar.dart';
import 'package:sound_cloud_clone/components/edit_profile_textfield.dart';
import 'package:sound_cloud_clone/components/update_loader.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final void Function() toggleForm;
  final TextEditingController cityController;
  final int nameRemaining;
  final int nameLimit;
  final int cityRemaining;
  final int cityLimit;
  final void Function(String) onNameChanged;
  final void Function(String) onCityChanged;
  final void Function() onSavePressed;
  final void Function(File?) onEditImage;
  final void Function(File?) onEditBannerImage;
  final String bannerImage;
  final String profileImage;
  final String country;
  final bool isLoading;

  const EditProfileForm({
    super.key,
    required this.country,
    required this.onEditImage,
    required this.onEditBannerImage,
    required this.bannerImage,
    required this.profileImage,
    required this.onSavePressed,
    required this.toggleForm,
    required this.nameRemaining,
    required this.nameLimit,
    required this.cityRemaining,
    required this.cityLimit,
    required this.onNameChanged,
    required this.onCityChanged,
    required this.nameController,
    required this.cityController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Bounce(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                nameRemaining == 50
                    ? const SizedBox()
                    : Bounce(
                        duration: const Duration(milliseconds: 100),
                        onPressed: onSavePressed,
                        child: isLoading
                            ? const UpdateLoader()
                            : Text(
                                'Save',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                EditBannerPic(
                  onEditBannerImage: onEditBannerImage,
                  bannerImage: bannerImage,
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: EditCircleAvatar(
                    profileImage: profileImage,
                    onEditImage: (File? image) => onEditImage(image),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: EditProfileTextfield(
              title: 'Display Name',
              limit: nameLimit,
              remaining: nameRemaining,
              controller: nameController,
              onChanged: onNameChanged,
              canBeEmpty: false,
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: EditProfileTextfield(
              canBeEmpty: true,
              title: 'City',
              limit: cityLimit,
              remaining: cityRemaining,
              controller: cityController,
              onChanged: onCityChanged,
            ),
          ),
          const Gap(10),
          InkWell(
            splashFactory: InkRipple.splashFactory,
            splashColor: Theme.of(context).colorScheme.secondary,
            onTap: toggleForm,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Text(
                    country.isEmpty ? 'Country' : country,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 14,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
