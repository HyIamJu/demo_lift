import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../shared/finite_state.dart';
import '../../../../viewmodels/cargolift_action_provider.dart';
import '../../../../viewmodels/cargolift_detail_provider.dart';
import '../../../../viewmodels/cargolift_logs_provider.dart';
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
    var providerLog = context.read<CargoLiftLogsProvider>();
    var providerDetail = context.read<LiftCargoDetailProvider>();
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _borderStyle,
        child: Consumer<LiftActionProvider>(builder: (context, liftControler, _) {
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
                onTap: liftControler.state.isLoading
                    ? null
                    : () async {
                        bool isSuccess = await liftControler.liftUp();

                        if (isSuccess == false) {
                          await providerLog.addHistory("UP");
                           providerDetail.changeStatusLift("UP");
                        }
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
                onTap: liftControler.state.isLoading
                    ? null
                    : () async {
                        bool isSuccess = await liftControler.liftHold();
                        if (isSuccess == false) {
                          await providerLog.addHistory("HOLD");
                          providerDetail.changeStatusLift("HOLD");
                        }
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
                onTap: liftControler.state.isLoading
                    ? null
                    : () async {
                        bool isSuccess = await liftControler.liftDown();
                        if (isSuccess == false) {
                          await providerLog.addHistory("DOWN");
                          providerDetail.changeStatusLift("DOWN");
                        }
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
                onTap: liftControler.state.isLoading
                    ? null
                    : () async {
                        bool isSuccess = await liftControler.emergencyStop();
                        if (isSuccess == false) {
                          
                          providerDetail.changeStatusLift("EMERGENCY");
                          // providerLog.addHistory("EMERGENCY");
                        }
                      },
              ),
            ],
          );
        }),
      ),
    );
  }
}
