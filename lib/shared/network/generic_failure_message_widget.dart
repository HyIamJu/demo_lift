import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class GenericFailureMessage extends StatelessWidget {
  const GenericFailureMessage({
    super.key,
    this.onTap,
    this.title,
    this.subText,
    this.txtColor = AppColors.black,
    this.btnColor = AppColors.blue,
  });
  final VoidCallback? onTap;
  final String? title;
  final String? subText;

  final Color txtColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (onTap == null)
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade900,
              size: 30,
            ),
          const Gap(10),
          if ((title ?? "").isNotEmpty) ...[
            Text(
              title ?? "Upss Error",
              textAlign: TextAlign.center,
              style: AppStyles.title2Medium.copyWith(
                color: txtColor,
              ),
            ),
            const Gap(4),
          ],
          if ((subText ?? "").isNotEmpty) ...[
            Text(
              subText ?? "",
              style: TextStyle(color: txtColor),
              textAlign: TextAlign.center,
            ),
            const Gap(14),
          ],
          if (onTap != null)
            SizedBox(
              width: width,
              child: OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: btnColor),
                  ),
                  child: Text(
                    "Retry",
                    style: TextStyle(color: btnColor),
                  )),
            ),
        ],
      ),
    );
  }
}
