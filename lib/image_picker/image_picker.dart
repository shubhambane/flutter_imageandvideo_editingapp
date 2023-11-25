import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<Future<XFile?>> pickImage() async {
    return ImagePicker().pickImage(source: ImageSource.gallery);
  }

  static Future<Future<XFile?>> takePhoto() async {
    return ImagePicker().pickImage(source: ImageSource.camera);
  }
}
