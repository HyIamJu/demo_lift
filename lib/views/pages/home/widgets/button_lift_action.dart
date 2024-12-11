import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';

class ButtonActionLift extends StatefulWidget {
  final String iconPath;
  final Color bgColor;
  final Color borderColor;
  final Color? iconColor;
  final void Function()? onTap;
  final bool isHoldType;

  const ButtonActionLift({
    super.key,
    this.onTap,
    this.bgColor = AppColors.backgroundGreen,
    this.borderColor = AppColors.greenLunatic,
    this.iconColor,
    this.iconPath = AppIcons.icUp,
    this.isHoldType = false,
  });

  @override
  State<ButtonActionLift> createState() => _ButtonActionLiftState();
}

class _ButtonActionLiftState extends State<ButtonActionLift> {
  final ValueNotifier<bool> _isHoldColor = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        highlightColor: widget.bgColor.withOpacity(0.5),
        focusColor: widget.bgColor.withOpacity(0.5),
        splashColor: widget.bgColor,
        onTapDown: widget.onTap != null
            ? (details) async {
                if (widget.isHoldType) {
                  await Future.delayed(Durations.medium1);
                  _isHoldColor.value = !_isHoldColor.value;
                }
              }
            : null,
        onTap: widget.onTap,
        child: ValueListenableBuilder(
            valueListenable: _isHoldColor,
            builder: (context, isPressed, _) {
              return Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isPressed ? widget.bgColor : Colors.transparent,
                  border: Border.all(
                    color: isPressed
                        ? widget.borderColor
                        : AppColors.grey.shade400,
                  ),
                ),
                child: SvgPicture.asset(
                  widget.iconPath,
                  height: 60,
                  colorFilter: widget.iconColor != null
                      ? ColorFilter.mode(
                          isPressed
                              ? widget.iconColor!
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
