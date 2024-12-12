import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../utils/media_services.dart';

class SelectMultipleImagesField extends StatefulWidget {
  const SelectMultipleImagesField({
    super.key,
    this.onImagesSelected,
    this.imageUrls,
    this.maxImages = 4,
    this.size = 60,
  });

  final void Function(List<File?>?)? onImagesSelected;
  final List<String>? imageUrls;
  final int maxImages;
  final double size;

  @override
  State<SelectMultipleImagesField> createState() => _SelectMultipleImagesFieldState();
}

class _SelectMultipleImagesFieldState extends State<SelectMultipleImagesField> {
  final ValueNotifier<List<File>> _images = ValueNotifier([]);
  final ValueNotifier<List<String>> _imageUrls = ValueNotifier([]);

  @override
  void initState() {
    _imageUrls.value = widget.imageUrls ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<File>>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (_imageUrls.value.isNotEmpty || value!.isNotEmpty) {
          return null;
        }
        return 'Please select at least one image';
      },
      builder: (FormFieldState<List<File>?> formState) {
        return ValueListenableBuilder(
          valueListenable: _images,
          builder: (context, images, child) {
            return Column(
              children: [
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < widget.maxImages; i++)
                      ValueListenableBuilder(
                        valueListenable: _imageUrls,
                        builder: (context, urls, child) {
                          if (urls.length > i) {
                            return Image.network(
                              urls[i],
                              height: widget.size.h,
                              width: widget.size.h,
                              fit: BoxFit.cover,
                            ).clipRRect(6);
                          } else {
                            return ValueListenableBuilder(
                              valueListenable: _images,
                              builder: (context, images, child) {
                                if (images.length > i) {
                                  return Image.file(
                                    images[i],
                                    height: widget.size.h,
                                    width: widget.size.h,
                                    fit: BoxFit.cover,
                                  ).withDottedBorder(padding: 6.edgeInsetsAll);
                                } else {
                                  return Icon(
                                    Icons.add_circle_outline_outlined,
                                    size: 24.sp,
                                    color: context.primaryColor,
                                  ).withDottedBorder(padding: 24.edgeInsetsAll);
                                }
                              },
                            );
                          }
                        },
                      ).onTap(() {
                        MediaServices.pickMultipleImages(maxImages: widget.maxImages).then((images) {
                          final pickedImages = images.map((e) => File(e.path)).toList();
                          _images.value = [_images.value, pickedImages].expand((element) => element).toList();
                          _imageUrls.value = [];
                          widget.onImagesSelected?.call(_images.value);
                          formState.didChange(_images.value);
                        });
                      }, borderRadius: 6.borderRadius).paddingRight(8),
                  ],
                ),
                if (formState.errorText != null) Text(formState.errorText!, style: context.errorStyle).paddingTop(8),
              ],
            );
          },
        );
      },
    );
  }
}
