import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/resources.dart';
import '../utils/media_services.dart';
import 'custom_bottom_sheet.dart';
import 'vertical_list_view.dart';

class ImageSourcesBottomSheet extends StatelessWidget {
  const ImageSourcesBottomSheet({super.key, this.onGalleryPressed, this.onCameraPressed});

  final void Function(File?)? onGalleryPressed;
  final void Function(File?)? onCameraPressed;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: 'Select Image Source',
      child: VerticalListView(
        enableScroll: false,
        padding: 0.edgeInsetsAll,
        separator: Divider(height: 0, indent: 56.sp),
        itemCount: ImageSource.values.length,
        itemBuilder: (_, index) {
          final source = ImageSource.values[index];
          return Row(
            children: [
              Icon(source.icon, size: 24.sp, color: context.iconColor),
              12.gap,
              Text(source.title, style: context.bodyLarge.s12.regular),
            ],
          ).paddingSymmetric(AppSize.screenPadding, 12.sp).onTap(() {
            MediaServices.pickImage(source: source).then((image) {
              if (image != null) {
                context.pop();
                if (source == ImageSource.camera && onCameraPressed != null) {
                  onCameraPressed!(File(image.path));
                } else if (source == ImageSource.gallery && onGalleryPressed != null) {
                  onGalleryPressed!(File(image.path));
                }
              }
            });
          });
        },
      ),
    );
  }
}
