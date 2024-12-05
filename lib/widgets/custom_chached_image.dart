import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  final String url;
  final Color bgColor;
  final BoxFit boxFit;
  final Duration durationAnimation;
  final double? height;
  final double? width;

  final Widget? placeHolder;
  final Widget? errorWidget;
  final Alignment alignment;

  const CustomCachedImage({
    super.key,
    required this.url,
    this.bgColor = AppColors.white,
    this.boxFit = BoxFit.cover,
    this.durationAnimation = Durations.short4,
    this.height,
    this.width,
    this.placeHolder,
    this.errorWidget,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      placeholderFadeInDuration: durationAnimation,
      alignment: alignment,
      imageUrl: url,
      fit: boxFit,
      filterQuality: FilterQuality.medium,
      placeholder: (_, __) =>
          placeHolder ??
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Container(color: Colors.white),
          ),
      errorWidget: (_, __, ____) => Container(
        color: AppColors.grey.shade100,
        child: errorWidget ??
            Center(
              child: Icon(
                Icons.image_not_supported,
                color: AppColors.grey.shade500,
              ),
            ),
      ),
    );
  }
}
