import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../shared/extensions/context_extenstion.dart';
import '../../viewmodels/auth_provider.dart';
import '../../viewmodels/nfc_scanner_provider.dart';

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
        elevation: 0.1,
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

Future<bool> showDialogScanBadgeAgain(BuildContext context) async {
  var nfcController = context.read<NFCProvider>();
  var authProv = context.read<AuthProvider>();
  final FocusNode focusNode = FocusNode();

  bool isRenewSession = false;
  
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.05,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: KeyboardListener(
          focusNode: focusNode,
          autofocus: true,
          onKeyEvent: (event) {
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
                      await authProv.loginWithoutNavigation(scannedCard).then((isSucces) {
                        if (isSucces) {
                          Navigator.pop(context);
                          isRenewSession = true;
                        }
                      },);
                    }
                  },
                );
              }
            }
          },
          child: Container(
            width: 600,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(16),
                SvgPicture.asset(AppIcons.icYourBadge),
                const Text(
                  'Silahkan tap badge kamu disebelah layar!',
                  style: AppStyles.title2Medium,
                ),
                const Text(
                  'Agar bisa menggunakan cargo lift.',
                  style: AppStyles.label2Regular,
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      );
    },
  );

  focusNode.dispose();
  return isRenewSession;
}
