import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sound_cloud_clone/utils/genre.dart';

class BsEditSelectedTrack extends StatefulWidget {
  final String title;
  const BsEditSelectedTrack({
    super.key,
    required this.title,
  });

  @override
  State<BsEditSelectedTrack> createState() => _BsEditSelectedTrackState();
}

class _BsEditSelectedTrackState extends State<BsEditSelectedTrack> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  'Edit',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.4,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    height: 150,
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Filename',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const Gap(16),
                  showGenreDropDown(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonHideUnderline showGenreDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                'Select Genre',
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onChanged: (val) {},
        items: getGenres()
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            )
            .toList(),
        alignment: Alignment.centerRight,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.surface,
          ),
          offset: const Offset(150, -10),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thumbColor: WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.tertiary),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(
            left: 14,
            right: 14,
          ),
        ),
      ),
    );
  }
}
