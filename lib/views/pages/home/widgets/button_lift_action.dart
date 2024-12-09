import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';

class ButtonActionLift extends StatelessWidget {
  final String iconPath;
  final Color bgColor;
  final Color borderColor;
  final Color? iconColor;
  final void Function()? onTap;

  ButtonActionLift({
    super.key,
    this.onTap,
    this.bgColor = AppColors.backgroundGreen,
    this.borderColor = AppColors.greenLunatic,
    this.iconColor,
    this.iconPath = AppIcons.icUp,
  });
  
  final ValueNotifier<bool> _isPressed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (details) {
          _isPressed.value = true;
        },
        onTapUp: (details) {
          _isPressed.value = false;
        },
        onTap: onTap,
        child: ValueListenableBuilder(
            valueListenable: _isPressed,
            builder: (context, isPressed, _) {
              return Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isPressed ? bgColor : Colors.transparent,
                  border: Border.all(
                    color: isPressed ? borderColor : AppColors.grey.shade400,
                  ),
                ),
                child: SvgPicture.asset(
                  iconPath,
                  height: 60,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(
                          isPressed
                              ? iconColor!
                              : AppColors.black.withOpacity(0.55),
                          BlendMode.srcIn,
                        )
                      : null,
                  fit: BoxFit.fitHeight,
                ),
              );
            }),
      ),
    );
  }
}
