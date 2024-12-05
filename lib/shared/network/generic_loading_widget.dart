import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';


class GenericCircleLoading extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final double strokeWidth;
  final double width;
  final double height;
  const GenericCircleLoading(
      {super.key,
      this.color = AppColors.red,
      this.bgColor = const Color.fromARGB(255, 243, 201, 205),
      this.strokeWidth = 5,
      this.width = 40,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          color: color,
          strokeCap: StrokeCap.round,
          backgroundColor: bgColor,
          strokeAlign: BorderSide.strokeAlignCenter,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
