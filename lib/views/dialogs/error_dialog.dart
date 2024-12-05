import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../shared/extensions/context_extenstion.dart';

showErrorDialog(
  BuildContext context, {
  int miliseconds = 1500,
  required String title,
  required String desc,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(
        Duration(milliseconds: miliseconds),
        () {
          Navigator.pop(context);
        },
      );
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: context.fullWidth * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.icWarningAlert),
              const Gap(16),
              Text(
                title,
                style: AppStyles.title2Medium,
              ),
              const Gap(8),
              Text(
                desc,
                style: AppStyles.label2Regular,
                // textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );
    },
  );
}
