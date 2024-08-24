import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:image_picker/image_picker.dart';

class EditBannerPic extends StatefulWidget {
  final void Function(File?) onEditBannerImage;
  final String bannerImage;
  const EditBannerPic({
    super.key,
    required this.bannerImage,
    required this.onEditBannerImage,
  });

  @override
  State<EditBannerPic> createState() => _EditBannerPicState();
}

class _EditBannerPicState extends State<EditBannerPic> {
  File? _bannerImageFromGallery;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _bannerImageFromGallery = File(pickedImage.path);
      });
      widget.onEditBannerImage(_bannerImageFromGallery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: _bannerImageFromGallery != null
              ? FileImage(_bannerImageFromGallery!)
              : NetworkImage(widget.bannerImage),
          height: 100,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Bounce(
            duration: const Duration(milliseconds: 100),
            onPressed: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withAlpha(200),
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
