import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/bs_country_picker.dart';
import 'package:sound_cloud_clone/components/edit_form.dart';
import 'package:sound_cloud_clone/models/user_model.dart';

class EditProfile extends StatefulWidget {
  final User? user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  int nameRemaining = 50;
  int nameLimit = 50;
  int cityRemaining = 35;
  int cityLimit = 35;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user!.name);
    nameLimit = nameLimit - widget.user!.name.length;
    nameRemaining = nameLimit;
    _cityController = TextEditingController(text: widget.user!.city);
    cityLimit = cityLimit - widget.user!.city.length;
    cityRemaining = cityLimit;
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
        onSavePressed: () {},
        nameRemaining: nameRemaining,
        nameLimit: nameLimit,
        cityRemaining: cityRemaining,
        cityLimit: cityLimit,
        onNameChanged: onNameChanged,
        onCityChanged: onCityChanged,
        toggleForm: () => setState(() {
              toggleForm = !toggleForm;
            }),
        nameController: _nameController,
        cityController: _cityController);
  }

  @override
  Widget build(BuildContext context) {
    return _currentState();
  }
}
