import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_cloud_clone/components/update_loader.dart';
import 'package:sound_cloud_clone/providers/track_provider.dart';
import 'package:sound_cloud_clone/providers/user_provider.dart';
import 'package:sound_cloud_clone/utils/genre.dart';
import 'package:sound_cloud_clone/utils/image_picker.dart';
import 'package:sound_cloud_clone/utils/toast.dart';
import 'package:just_audio/just_audio.dart';

class BsEditSelectedTrack extends ConsumerStatefulWidget {
  final FilePickerResult result;
  const BsEditSelectedTrack({
    super.key,
    required this.result,
  });

  @override
  ConsumerState<BsEditSelectedTrack> createState() =>
      _BsEditSelectedTrackState();
}

class _BsEditSelectedTrackState extends ConsumerState<BsEditSelectedTrack> {
  late TextEditingController _titleController;
  final TextEditingController _descriptionController =
      TextEditingController(text: 'give a description');
  bool isPrivate = false;
  String? _selectedGenre = 'none';
  File? _trackImageFromGallery;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late Duration? _duration;

  @override
  void initState() {
    super.initState();
    getAudioDuration();
    _titleController = TextEditingController(
      text: widget.result.files.single.name,
    );
  }

  Future getAudioDuration() async {
    await _audioPlayer.setFilePath(widget.result.files.single.path!);
    _duration = _audioPlayer.duration;
  }

  void selectTrackImage() async {
    final XFile? pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        _trackImageFromGallery = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void saveSelectedTrack({required WidgetRef ref}) async {
    String imagePrefix = 'data:image/jpeg;base64,';
    final userId = ref.read(userProvider)!.id;
    final trackRef = ref.read(trackProvider.notifier);
    if (_trackImageFromGallery != null) {
      final imageBytes = await _trackImageFromGallery!.readAsBytes();
      final String imageInBytes = base64Encode(imageBytes);
      imagePrefix += imageInBytes;
    }
    final data = {
      'title': _titleController.text,
      'genre': _selectedGenre,
      'description': _descriptionController.text,
      'isPrivate': isPrivate,
      'trackData': {'publicId': 'koi ni', 'url': 'koi ni'},
      'duration': {
        'inSeconds': _duration!.inSeconds,
        'inMinutes': _duration!.inMinutes
      },
      if (_trackImageFromGallery != null) 'trackImageFromGallery': imagePrefix,
    };
    await trackRef.uploadTrack(
      data,
      id: userId,
      audioFile: File(widget.result.files.single.path!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(trackProvider).isLoading == true;
    ref.listen(
        trackProvider,
        (_, next) => next.when(
              data: (data) {
                getToast('Track Uploaded Successfully');
                Navigator.of(context).pop();
              },
              error: (error, stackTrace) {
                getToast(error.toString());
              },
              loading: () {},
            ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  'Edit',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                isLoading
                    ? const UpdateLoader()
                    : TextButton(
                        onPressed: () => saveSelectedTrack(ref: ref),
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
                  InkWell(
                    onTap: selectTrackImage,
                    child: _trackImageFromGallery != null
                        ? SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Image(
                              image: FileImage(_trackImageFromGallery!),
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            height: 150,
                            child: Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).colorScheme.primary,
                            ),
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
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Describe your track',
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                  ),
                  const Gap(16),
                  showGenreDropDown(),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Private',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Switch(
                        // thumbColor: WidgetStateProperty.all(
                        //   Theme.of(context).colorScheme.tertiary,
                        // ),
                        activeColor: Theme.of(context).colorScheme.primary,
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        value: isPrivate,
                        onChanged: (val) => setState(() => isPrivate = val),
                      ),
                    ],
                  ),
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
                _selectedGenre != null ? _selectedGenre! : 'Select Genre',
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onChanged: (val) {
          setState(() {
            _selectedGenre = val;
          });
        },
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
