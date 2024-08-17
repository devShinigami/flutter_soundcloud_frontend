import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/edit_profile_textfield.dart';

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

  const EditProfileForm({
    super.key,
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
                Bounce(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: nameRemaining == 50
                        ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary)
                        : Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 200,
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(
                    'https://th.bing.com/th/id/R.28b96f1c49c31622589fe9ea4b00dc71?rik=%2b48fTHbS88tJjQ&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f19500000%2fTobi-tobi-19529893-1280-720.jpg&ehk=9Sr7gbjRKCuflqYyYB4zHwSMMtFAgQqCmuej9DqkdYs%3d&risl=&pid=ImgRaw&r=0',
                  ),
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://wallpapercave.com/wp/ZYHYAMM.jpg',
                    ),
                    radius: 42,
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
          const Gap(20),
          InkWell(
            onTap: toggleForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Country',
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
