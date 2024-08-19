import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_cloud_clone/components/custom_button.dart';

class EditCircleAvatar extends StatefulWidget {
  final void Function(File?) onEditImage;
  final String profileImage;
  const EditCircleAvatar({
    super.key,
    required this.profileImage,
    required this.onEditImage,
  });

  @override
  State<EditCircleAvatar> createState() => _EditCircleAvatarState();
}

class _EditCircleAvatarState extends State<EditCircleAvatar> {
  File? _imageFromLibrary;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFromLibrary = File(pickedImage.path);
      });
      widget.onEditImage(_imageFromLibrary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () => _editDialog(context),
      duration: const Duration(milliseconds: 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CircleAvatar(
          backgroundImage: _imageFromLibrary != null
              ? FileImage(_imageFromLibrary!)
              : NetworkImage(widget.profileImage) as ImageProvider,
          radius: 42,
          child: SizedBox.expand(
            child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                )),
          ),
        ),
      ),
    );
  }

  void _editDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Gap(5),
                    Text(
                      'Edit Photo',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Divider(
                      height: 0,
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    MyButton(
                      onTap: _pickImage,
                      txt: 'Choose from library',
                      color: Theme.of(context).primaryColor,
                    ),
                    Divider(
                      height: 0,
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    MyButton(
                      onTap: () {},
                      textColor: Colors.red,
                      txt: 'Delete profile picture',
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const Gap(5),
              MyButton(
                onTap: () {
                  Navigator.pop(context);
                },
                txt: 'Cancel',
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
