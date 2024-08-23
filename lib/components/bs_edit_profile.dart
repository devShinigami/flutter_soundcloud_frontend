import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/bs_country_picker.dart';
import 'package:sound_cloud_clone/components/edit_form.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';
import 'package:sound_cloud_clone/utils/toast.dart';

class EditProfile extends ConsumerStatefulWidget {
  final User user;
  const EditProfile({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController _nameController;
  late String _selectedImage;
  File? _imageFromLibrary;
  late TextEditingController _cityController;
  late TextEditingController _bioController;
  int nameRemaining = 50;
  int nameLimit = 50;
  int cityRemaining = 35;
  int cityLimit = 35;
  late String country;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    nameLimit = nameLimit - 6;
    nameRemaining = nameLimit;
    country = widget.user.country;
    _cityController = TextEditingController(text: widget.user.city);
    _bioController = TextEditingController(text: widget.user.bio);
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
        onCountryChanged: (value) => onCountryChanged(value),
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
      country: country,
      cityLimit: cityLimit,
      isLoading: isLoading,
      onNameChanged: onNameChanged,
      onCityChanged: onCityChanged,
      toggleForm: () => setState(() {
        toggleForm = !toggleForm;
      }),
      nameController: _nameController,
      cityController: _cityController,
    );
  }

  void onCountryChanged(String country) {
    setState(() {
      this.country = country;
    });
  }

  void onFormSave() async {
    FocusScope.of(context).unfocus();
    final navigator = Navigator.of(context);
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> changes = {
      if (widget.user.name != _nameController.text)
        'name': _nameController.text,
      if (widget.user.city != _cityController.text)
        'city': _cityController.text,
      if (widget.user.bio != _bioController.text) 'bio': _bioController.text,
      if (widget.user.bio != _bioController.text) 'bio': _bioController.text,
      if (widget.user.country != country) 'country': country,
    };

    if (changes.isNotEmpty) {
      await ref.read(userProvider.notifier).update(changes, id: widget.user.id);
    } else {
      getToast('No changes made');
    }
    setState(() {
      isLoading = false;
    });
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return _currentState();
  }
}
