import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/context_extensions.dart';

import 'shimmer_widget.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.height,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.errorWidget,
    this.isCircular = false,
  });

  final String imageUrl;
  final double height;
  final double? width;
  final BoxFit fit;
  final bool isCircular;
  final BorderRadiusGeometry borderRadius;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (_, __) {
          if (isCircular) {
            return ShimmerWidget.circular(radius: height / 2);
          } else {
            return ShimmerWidget.rectangular(
                width: width ?? context.width,
                height: height,
                shapeBorder: RoundedRectangleBorder(borderRadius: borderRadius));
          }
        },
        errorWidget: (_, __, ___) => Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: errorWidget ??
                CustomImage(
                  fit: fit,
                  width: width,
                  height: height,
                  imageUrl: '',
                  borderRadius: borderRadius,
                  isCircular: isCircular,
                ),
          ),
        ),
        imageBuilder: (_, imageProvider) {
          return Container(
            decoration: ShapeDecoration(
              image: DecorationImage(image: imageProvider, fit: fit),
              shape: isCircular ? const CircleBorder() : RoundedRectangleBorder(borderRadius: borderRadius),
            ),
          );
        },
      );
    });
  }
}
