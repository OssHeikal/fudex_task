import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../utils/validators.dart';
import 'image_sources_bottom_sheet.dart';

class SelectImageField extends StatefulWidget {
  const SelectImageField({
    super.key,
    this.imageUrl,
    this.validator,
    this.onImageSelected,
    this.isLoading = false,
    this.size = 120,
    this.iconSize = 24,
    this.padding = 65,
  });

  final double size;
  final double iconSize;
  final double padding;
  final String? imageUrl;
  final void Function(File?)? onImageSelected;
  final String? Function(File?)? validator;
  final bool isLoading;

  @override
  State<SelectImageField> createState() => _SelectImageFieldState();
}

class _SelectImageFieldState extends State<SelectImageField> {
  final ValueNotifier<File?> _image = ValueNotifier(null);
  final ValueNotifier<String?> _imageUrl = ValueNotifier(null);

  @override
  void initState() {
    _imageUrl.value = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          } else {
            if (_imageUrl.value != null) {
              return null;
            }
            return Validator.validateFile(value, message: 'Please select an image');
          }
        },
        builder: (FormFieldState<File?> formState) {
          return ValueListenableBuilder(
            valueListenable: _imageUrl,
            builder: (context, url, child) {
              if (url != null && _image.value == null) {
                if (url.startsWith('http')) {
                  return Image.network(
                    url,
                    height: widget.size.sp,
                    width: widget.size.sp,
                    fit: BoxFit.cover,
                  ).clipRRect(6);
                } else {
                  return Image.file(
                    File(url),
                    height: widget.size.sp,
                    width: widget.size.sp,
                    fit: BoxFit.cover,
                  ).clipRRect(6);
                }
              } else {
                return Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _image,
                      builder: (context, File? value, child) {
                        return (value != null
                                ? Image.file(
                                    value,
                                    height: widget.size.sp,
                                    width: widget.size.sp,
                                    fit: BoxFit.cover,
                                  ).withDottedBorder(padding: 6.edgeInsetsAll)
                                : Icon(
                                    Icons.add_circle_outline,
                                    size: widget.iconSize.sp,
                                    color: context.primaryColor,
                                  ).withDottedBorder(padding: 52.edgeInsetsAll))
                            .animationSwitch();
                      },
                    ).onTap(() {
                      if (widget.isLoading) return;
                      _onPhotoPressed(formState);
                    }, borderRadius: 6.borderRadius),
                    8.gap,
                    if (formState.errorText != null) Text(formState.errorText!, style: context.errorStyle),
                  ],
                );
              }
            },
          );
        });
  }

  void _onPhotoPressed(FormFieldState<File?>? formState) {
    context.showBottomSheet(
      ImageSourcesBottomSheet(
        onCameraPressed: (image) {
          _image.value = image;
          _imageUrl.value = null;
          widget.onImageSelected?.call(image);
          formState?.didChange(image);
        },
        onGalleryPressed: (image) {
          _image.value = image;
          _imageUrl.value = null;
          widget.onImageSelected?.call(image);
          formState?.didChange(image);
        },
      ),
    );
  }
}
