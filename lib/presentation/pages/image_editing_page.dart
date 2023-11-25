import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import '../../utils/image_utils.dart';

class ImageEditingPage extends StatefulWidget {
  @override
  _ImageEditingPageState createState() => _ImageEditingPageState();
}

class _ImageEditingPageState extends State<ImageEditingPage> {
  late img.Image _originalImage;
  late img.Image _editedImage;

  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;

  @override
  void initState() {
    super.initState();
    _loadDefaultImage();
  }

  void _loadDefaultImage() async {
    final pickedFile = await ImagePickerHelper.pickImage(ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      _originalImage = ImagePickerHelper.loadImage(bytes);
    } else {
      _originalImage = img.Image(width: 100, height: 100);
    }

    _editedImage = ImagePickerHelper.applyEffects(
        _originalImage, _brightness, _contrast, _saturation);
    setState(() {});
  }

  void _updateEditedImage() {
    _editedImage = ImagePickerHelper.applyEffects(
        _originalImage, _brightness, _contrast, _saturation);
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePickerHelper.pickImage(ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      _originalImage = ImagePickerHelper.loadImage(bytes);
      _updateEditedImage();
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await ImagePickerHelper.pickImage(ImageSource.camera);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      _originalImage = ImagePickerHelper.loadImage(bytes);
      _updateEditedImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Editing'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child:
                  Image.memory(Uint8List.fromList(img.encodeJpg(_editedImage))),
            ),
          ),
          _buildSlider('Brightness', -1.0, 1.0, _brightness, (value) {
            setState(() {
              _brightness = value;
              _updateEditedImage();
            });
          }),
          _buildSlider('Contrast', 0.0, 3.0, _contrast, (value) {
            setState(() {
              _contrast = value;
              _updateEditedImage();
            });
          }),
          _buildSlider('Saturation', 0.0, 3.0, _saturation, (value) {
            setState(() {
              _saturation = value;
              _updateEditedImage();
            });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              ElevatedButton(
                onPressed: _takePhoto,
                child: Text('Take Photo'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double min, double max, double value,
      ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
