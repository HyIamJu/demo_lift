import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../shared/finite_state.dart';
import '../../../../viewmodels/auth_provider.dart';
import '../../../../viewmodels/cargolift_action_provider.dart';
import '../../../../viewmodels/cargolift_detail_provider.dart';
import '../../../../viewmodels/cargolift_logs_provider.dart';
import '../../../../viewmodels/nfc_scanner_provider.dart';
import '../../../dialogs/error_dialog.dart';
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
    
    var nfcController = context.read<NFCProvider>();
    final FocusNode focusNode = FocusNode();

    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _borderStyle,
        child:
            Consumer2<LiftActionProvider, AuthProvider>(builder: (context, liftControler, authControler, _) {
          return KeyboardListener(
            focusNode: focusNode,
            autofocus: true,
            onKeyEvent:
            authControler.state .isLoading ?
            null :
             (event) {
              if (event is KeyDownEvent) {
                // Tangkap karakter yang diinput
                final String key = event.logicalKey.keyLabel;
                // Periksa apakah key bukan kosong
                if (key.isNotEmpty) {
                  nfcController.appendScannedData(key);
                }
                // Periksa jika NFC reader mengirimkan karakter seperti "Enter" (ID selesai dikirim)
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  // Proses data NFC yang sudah selesai
                  nfcController.processScannedData(
                    (scannedCard) async {
                      if (scannedCard.isNotEmpty && scannedCard.length > 4) {
                        await authControler.loginWithoutNavigation(scannedCard).then(
                          (isSucces) {
                            if (isSucces) {
                              liftControler.renewTimeStamp();
                            }
                          },
                        );
                      }
                    },
                  );
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ----------------------------------------------
                // BUTTON UP
                // ----------------------------------------------
                ButtonActionLift(
                  iconPath: AppIcons.icUp,
                  borderColor: AppColors.greenLunatic,
                  iconColor: AppColors.green,
                  onTap: (liftControler.state.isLoading ||
                          liftControler.isEmergencyActive)
                      ? null
                      : () async {
                          if (liftControler.isSessionExpired()) {
                            bool isSuccesRenewSession =
                                await showDialogScanBadgeAgain(context);
                            if (isSuccesRenewSession) {
                              bool isSuccess = await liftControler.liftUp();

                              if (isSuccess) {
                                await providerLog.addHistory("UP");
                                providerDetail.changeStatusLift("UP");
                              }
                            }
                          } else {
                            bool isSuccess = await liftControler.liftUp();
                            if (isSuccess) {
                              await providerLog.addHistory("UP");
                              providerDetail.changeStatusLift("UP");
                            }
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
                  onTap: (liftControler.state.isLoading ||
                          liftControler.isEmergencyActive)
                      ? null
                      : () async {
                          if (liftControler.isSessionExpired()) {
                            bool isSuccesRenewSession =
                                await showDialogScanBadgeAgain(context);
                            if (isSuccesRenewSession) {
                              bool isSuccess = await liftControler.liftHold();

                              if (isSuccess) {
                                await providerLog.addHistory("HOLD");
                                providerDetail.changeStatusLift("HOLD");
                              }
                            }
                          } else {
                            bool isSuccess = await liftControler.liftHold();
                            if (isSuccess) {
                              await providerLog.addHistory("HOLD");
                              providerDetail.changeStatusLift("HOLD");
                            }
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
                  onTap: (liftControler.state.isLoading ||
                          liftControler.isEmergencyActive)
                      ? null
                      : () async {
                          if (liftControler.isSessionExpired()) {
                            bool isSuccesRenewSession =
                                await showDialogScanBadgeAgain(context);
                            if (isSuccesRenewSession) {
                              bool isSuccess = await liftControler.liftDown();

                              if (isSuccess) {
                                await providerLog.addHistory("DOWN");
                                providerDetail.changeStatusLift("DOWN");
                              }
                            }
                          } else {
                            bool isSuccess = await liftControler.liftDown();
                            if (isSuccess) {
                              await providerLog.addHistory("DOWN");
                              providerDetail.changeStatusLift("DOWN");
                            }
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
                  isHoldType: true,
                  onTap: liftControler.state.isLoading
                      ? null
                      : () async {
                          if (liftControler.isEmergencyActive) {
                            bool isSuccess =
                                await liftControler.emergencyStop();
                            if (isSuccess) {
                              providerDetail.changeStatusLift("EMERGENCY");
                            }
                          } else {
                            bool isSuccess =
                                await liftControler.emergencyStart();
                            if (isSuccess) {
                              providerDetail.changeStatusLift("EMERGENCY");
                            }
                          }
                        },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
