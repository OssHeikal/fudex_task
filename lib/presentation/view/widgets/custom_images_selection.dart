import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:fudex/core/widgets/select_image_field.dart';
import 'package:fudex/core/widgets/select_multiple_images_field.dart';

class CustomImagesSelection extends StatelessWidget {
  const CustomImagesSelection({
    super.key,
    this.images,
    this.mainImageUrl,
    this.onImageSelected,
    this.onImagesSelected,
  });

  final List<String>? images;
  final String? mainImageUrl;
  final void Function(File?)? onImageSelected;
  final void Function(List<File?>?)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectImageField(
          imageUrl: mainImageUrl,
          onImageSelected: (file) {
            onImageSelected?.call(file);
          },
        ),
        16.gap,
        SelectMultipleImagesField(
          onImagesSelected: (images) {
            onImagesSelected?.call(images);
          },
        ),
      ],
    ).withDottedBorder(padding: 16.edgeInsetsAll);
  }
}
