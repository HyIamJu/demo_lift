import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomContainerButton extends StatelessWidget {
  final Widget iconPath;
  final String text;
  final void Function()? onTap;

  const CustomContainerButton({
    super.key,
    required this.iconPath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconPath,
            const Gap(4),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                text,
                style: AppStyles.label3Medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
