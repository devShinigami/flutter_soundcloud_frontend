import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/bs_country_picker.dart';
import 'package:sound_cloud_clone/components/edit_form.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late String _selectedImage;
  File? _imageFromLibrary;
  late TextEditingController _cityController;
  late TextEditingController _bioController;
  int nameRemaining = 50;
  int nameLimit = 50;
  int cityRemaining = 35;
  int cityLimit = 35;
  String country = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'hashir');
    nameLimit = nameLimit - 6;
    nameRemaining = nameLimit;
    _cityController = TextEditingController(text: 'multan');
    _bioController = TextEditingController(text: 'I am a developer');
    cityLimit = cityLimit - 6;
    cityRemaining = cityLimit;
    _selectedImage =
        "https://th.bing.com/th/id/R.28b96f1c49c31622589fe9ea4b00dc71?rik=%2b48fTHbS88tJjQ&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f19500000%2fTobi-tobi-19529893-1280-720.jpg&ehk=9Sr7gbjRKCuflqYyYB4zHwSMMtFAgQqCmuej9DqkdYs%3d&risl=&pid=ImgRaw&r=0";
  }

  void onNameChanged(String text) {
    setState(() {
      nameRemaining = 50 - text.length;
      nameLimit = nameRemaining;
    });
  }

  void onCityChanged(String text) {
    setState(() {
      cityRemaining = 50 - text.length;
      cityLimit = cityRemaining;
    });
  }

  void onEditImage(File? image) {
    setState(() {
      _imageFromLibrary = image;
      debugPrint(_imageFromLibrary.toString());
    });
  }

  bool toggleForm = false;

  Widget _currentState() {
    if (toggleForm) {
      return BottomSheetCountries(
        key: const ValueKey('bottom_sheet_countries'),
        toggleForm: () => setState(
          () {
            toggleForm = !toggleForm;
          },
        ),
      );
    }
    return EditProfileForm(
      key: const ValueKey('edit_profile_form'),
      onSavePressed: onFormSave,
      profileImage: _selectedImage,
      nameRemaining: nameRemaining,
      onEditImage: onEditImage,
      nameLimit: nameLimit,
      cityRemaining: cityRemaining,
      cityLimit: cityLimit,
      onNameChanged: onNameChanged,
      onCityChanged: onCityChanged,
      toggleForm: () => setState(() {
        toggleForm = !toggleForm;
      }),
      nameController: _nameController,
      cityController: _cityController,
    );
  }

  void onFormSave() async {}

  @override
  Widget build(BuildContext context) {
    return _currentState();
  }
}
