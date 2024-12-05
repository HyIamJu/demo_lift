// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../dialogs/error_dialog.dart';

class HomeButtonSectionView extends StatefulWidget {
  final Function(String) onLiftStatusChanged;
  final int flex;

  const HomeButtonSectionView({super.key, required this.onLiftStatusChanged, required this.flex});

  @override _HomeButtonSectionViewState createState() => _HomeButtonSectionViewState();
}

class _HomeButtonSectionViewState extends State<HomeButtonSectionView> {
  bool isTapUp = false;
  bool isTapDown = false;
  bool isHoldTapped = false;
  bool isEmergency = false;
  String liftStatus = '';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _borderStyle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ----------------------------------------------
            // BUTTON UP
            // ----------------------------------------------
            _buttonUpSection(context),
            const Gap(10),
            // ----------------------------------------------
            // BUTTON HOLD
            // ----------------------------------------------
            _buttonHoldSection(),
            const Gap(10),
            // ----------------------------------------------
            // BUTTON DOWN
            // ----------------------------------------------
            _buttonDownSection(context),
            const Gap(10),
            // ----------------------------------------------
            // BUTTON EMERGENCY
            // ----------------------------------------------
            _buttonEmergencySection(),
          ],
        ),
      ),
    );
  }

  Expanded _buttonDownSection(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Jika tombol Hold sudah ditekan dan tombol Up sudah ditekan, wqbaru bisa tekan Down
            if (isHoldTapped || !isHoldTapped) {
              isTapDown = !isTapDown;
              if (isTapDown) {
                isTapUp = false;
                isHoldTapped = false;
                liftStatus = 'DOWN';
                widget.onLiftStatusChanged(liftStatus);
              } else {
                liftStatus = '-';
                widget.onLiftStatusChanged(liftStatus);
              }
            } else {
              // Jika tombol Hold belum ditekan
              showErrorDialog(context,
                  miliseconds: 1500,
                  title: 'Tekan hold terlebih dahulu',
                  desc: 'Jika ingin turun kebawah');
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isTapDown ? AppColors.backgroundGreen : Colors.transparent,
            border: Border.all(
              color:
                  isTapDown ? AppColors.greenLunatic : AppColors.grey.shade400,
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.icDown,
            height: 60,
            color:
                isTapDown ? AppColors.green : AppColors.black.withOpacity(0.55),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Expanded _buttonHoldSection() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isHoldTapped = !isHoldTapped;
            if (isHoldTapped) {
              liftStatus = 'HOLD';
              widget.onLiftStatusChanged(liftStatus);
            } else {
              liftStatus = '-';
              widget.onLiftStatusChanged(liftStatus);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isHoldTapped ? AppColors.backgroundYellow : Colors.transparent,
            border: Border.all(
              color: isHoldTapped
                  ? const Color(0xFFFFB100)
                  : AppColors.grey.shade400,
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.icHold,
            height: 60,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Expanded _buttonUpSection(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isHoldTapped || !isHoldTapped) {
            setState(() {
              isTapUp = !isTapUp;
              if (isTapUp) {
                isTapDown = false;
                isHoldTapped = false;
                liftStatus = 'UP';
                widget.onLiftStatusChanged(liftStatus);
              } else {
                liftStatus = '-';
                widget.onLiftStatusChanged(liftStatus);
              }
            });
          } else {
            // Jika tombol Hold belum ditekan
            showErrorDialog(context,
                miliseconds: 1500,
                title: 'Tekan hold terlebih dahulu',
                desc: 'Jika ingin naik ke atas');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isTapUp ? AppColors.backgroundGreen : Colors.transparent,
            border: Border.all(
              color: isTapUp ? AppColors.greenLunatic : AppColors.grey.shade400,
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.icUp,
            height: 60,
            color:
                isTapUp ? AppColors.green : AppColors.black.withOpacity(0.55),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Expanded _buttonEmergencySection() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEmergency = !isEmergency;
            if (isEmergency) {
              liftStatus = 'EMERGENCY';
              widget.onLiftStatusChanged(liftStatus);
            } else {
              liftStatus = '-';
              widget.onLiftStatusChanged(liftStatus);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isEmergency ? AppColors.backgroundRed : AppColors.white,
            border: Border.all(color: AppColors.grey.shade400),
          ),
          child: SvgPicture.asset(
            AppIcons.icEmergency,
            height: 60,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

BoxDecoration get _borderStyle => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.grey.shade400),
    );
