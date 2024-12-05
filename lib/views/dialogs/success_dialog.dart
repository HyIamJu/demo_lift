import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../shared/extensions/context_extenstion.dart';

showDialogSuccess(BuildContext context, {int miliseconds = 1500}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(milliseconds: miliseconds), () {
        Navigator.of(context).pop();
      });
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: context.fullWidth * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.icSuccess,
                height: 80,
                width: 80,
              ),
              const Gap(16),
              const Text(
                'Switch berhasil',
                style: AppStyles.title2Medium,
              ),
              const Gap(8),
              const Text(
                'Switch kargo lift telah diganti',
                style: AppStyles.label2Regular,
              ),
            ],
          ),
        ),
      );
    },
  );
}
