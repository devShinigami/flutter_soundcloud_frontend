import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/bs_country_picker.dart';
import 'package:sound_cloud_clone/components/edit_form.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';

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
  String? _imageFromLibrary;
  String? _bannerImageFromGallery;
  late String _selectedBannerImage;
  late TextEditingController _cityController;
  late TextEditingController _bioController;
  int nameRemaining = 50;
  int nameLimit = 50;
  int cityRemaining = 35;
  int cityLimit = 35;
  late String country;
  bool isLoading = false;
  bool isDeletedProfilePic = false;
  bool isDeletedBannerPic = false;

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
    _selectedImage = widget.user.profilePic.url;
    _selectedBannerImage = widget.user.bannerPic.url;
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

  void onEditImage(File? image) async {
    final bytes = await image!.readAsBytes();
    final base64Image = base64Encode(bytes);
    final imagePrefix = 'data:image/jpeg;base64,$base64Image';
    // setState(() {
    _imageFromLibrary = imagePrefix;
    isDeletedProfilePic = true;
    // });
  }

  void onEditBannerImage(File? bannerImage) async {
    final bytes = await bannerImage!.readAsBytes();
    final base64Image = base64Encode(bytes);
    final imagePrefix = 'data:image/jpeg;base64,$base64Image';
    _bannerImageFromGallery = imagePrefix;
    isDeletedBannerPic = true;
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
      onEditBannerImage: onEditBannerImage,
      onEditImage: onEditImage,
      nameLimit: nameLimit,
      bannerImage: _selectedBannerImage,
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
      if (_imageFromLibrary != null) 'imageFromGallery': _imageFromLibrary,
      if (_imageFromLibrary != null)
        'profilePic': {
          'url': widget.user.profilePic.url,
          'public_id': widget.user.profilePic.publicId,
        },
      'isDeletedProfilePic': isDeletedProfilePic,
      if (_bannerImageFromGallery != null)
        'bannerImageFromGallery': _bannerImageFromGallery,
      if (_bannerImageFromGallery != null)
        'bannerPic': {
          'url': widget.user.bannerPic.url,
          'public_id': widget.user.bannerPic.publicId,
        },
      'isDeletedBannerPic': isDeletedBannerPic,
    };

    if (changes.isNotEmpty) {
      await ref.read(userProvider.notifier).update(changes, id: widget.user.id);
    }
    setState(() {
      isLoading = false;
    });
    _imageFromLibrary = null;
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return _currentState();
  }
}
