import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImagePickerHelper {
  static Future<Future<XFile?>> pickImage(ImageSource source) async {
    return ImagePicker().pickImage(source: source);
  }

  static img.Image loadImage(Uint8List bytes) {
    return img.decodeImage(Uint8List.fromList(bytes))!;
  }

  static img.Image applyEffects(img.Image originalImage, double brightness,
      double contrast, double saturation) {
    img.Image editedImage = img.copyRotate(originalImage, angle: 0);
    editedImage = img.brightness(editedImage, brightness);
    editedImage = img.contrast(editedImage, contrast);
    editedImage = img.saturation(editedImage, saturation);
    return editedImage;
  }
}
