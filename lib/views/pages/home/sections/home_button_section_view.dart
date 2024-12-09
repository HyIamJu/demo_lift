import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../shared/finite_state.dart';
import '../../../../viewmodels/cargolift_action_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../widgets/button_lift_action.dart';

class HomeButtonSectionView extends StatelessWidget {
  const HomeButtonSectionView({
    super.key,
  });

  BoxDecoration get _borderStyle => BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.shade400),
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _borderStyle,
        child: Consumer<LiftActionProvider>(builder: (context, provider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ----------------------------------------------
              // BUTTON UP
              // ----------------------------------------------
              ButtonActionLift(
                iconPath: AppIcons.icUp,
                borderColor: AppColors.greenLunatic,
                iconColor: AppColors.green,
                onTap: provider.state.isLoading
                    ? null
                    : () async{
                        await provider.liftUp();
                      },
              ),
              const Gap(10),

              // ----------------------------------------------
              // BUTTON HOLD
              // ----------------------------------------------
              ButtonActionLift(
                iconPath: AppIcons.icHold,
                bgColor: AppColors.backgroundYellow,
                borderColor: const Color(0xFFFFB100),
                onTap: provider.state.isLoading
                    ? null
                    : () async{
                        await  provider.liftHold();
                      },
              ),
              const Gap(10),

              // ----------------------------------------------
              // BUTTON DOWN
              // ----------------------------------------------
              ButtonActionLift(
                iconPath: AppIcons.icDown,
                bgColor: AppColors.backgroundGreen,
                borderColor: AppColors.greenLunatic,
                iconColor: AppColors.green,
                onTap: provider.state.isLoading
                    ? null
                    : () async{
                        await  provider.liftDown();
                      },
              ),
              const Gap(10),

              // ----------------------------------------------
              // BUTTON EMERGENCY
              // ----------------------------------------------
              ButtonActionLift(
                iconPath: AppIcons.icEmergency,
                bgColor: AppColors.backgroundRed,
                borderColor: AppColors.grey.shade400,
                onTap: provider.state.isLoading
                    ? null
                    : () async{
                        await provider.emergencyStop();
                      },
              ),
            ],
          );
        }),
      ),
    );
  }
}
