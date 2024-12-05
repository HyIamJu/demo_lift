import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../constants/app_assets.dart';

class CustomRowList extends StatelessWidget {
  final String name;
  final String desc;
  final bool isRed;
  final int nameFlex;
  final int descFlex;
  final TextStyle? nameTextStyle;
  final TextStyle? descTextStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final Widget? icon;

  const CustomRowList({
    super.key,
    required this.name,
    required this.desc,
    this.nameFlex = 1,
    this.descFlex = 4,
    this.nameTextStyle,
    this.descTextStyle,
    this.isRed = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 6,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: nameFlex,
          child: Text(
            name,
            style: nameTextStyle ??
                AppStyles.label2SemiBold
                    .copyWith(color: AppColors.black.shade400),
          ),
        ),
        Gap(gap),
        Flexible(
          flex: descFlex,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    desc,
                    style: descTextStyle ??
                        AppStyles.label2Regular.copyWith(
                          color:
                              isRed ? AppColors.red : AppColors.black.shade500,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Gap(6),
                if (desc.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _getStatusIcons(desc),
                  ),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: icon!,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getStatusIcons(String status) {
    if (status.toLowerCase() == 'up') {
      return SvgPicture.asset(AppIcons.icStatusUp);
    } else if (status.toLowerCase() == 'hold') {
      return SvgPicture.asset(AppIcons.icStatusHold);
    } else if (status.toLowerCase() == 'down') {
      return SvgPicture.asset(AppIcons.icStatusDown);
    } else if (status.toLowerCase() == 'emergency') {
      return SvgPicture.asset(AppIcons.icStatusEmergency);
    }
    return const SizedBox.shrink();
  }
}
