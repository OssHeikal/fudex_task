import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

extension ImageSourceExt on ImageSource {
  IconData get icon {
    switch (this) {
      case ImageSource.camera:
        return Icons.camera_alt;
      case ImageSource.gallery:
        return Icons.image;
      default:
        return Icons.image;
    }
  }

  String get title {
    switch (this) {
      case ImageSource.camera:
        return 'Take a photo';
      case ImageSource.gallery:
        return 'Choose from gallery';
      default:
        return 'Choose from gallery';
    }
  }
}
