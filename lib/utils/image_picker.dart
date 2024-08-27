import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return pickedImage;
  }
  return null;
}
