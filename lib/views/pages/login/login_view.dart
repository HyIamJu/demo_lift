import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../viewmodels/Nfc_scanner_provider.dart';
import '../../../viewmodels/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_styles.dart';

import '../../../viewmodels/clock_provider.dart';
import '../../../widgets/custom_container_button.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    var nfcProv = context.read<NFCProvider>();
    // Fokuskan pada widget saat halaman ditampilkan
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nfcProv.resetScannedData();

      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nfcProv = context.read<NFCProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------
            // DATEFORMAT SECTION
            // ----------------------------------------------
            _dateFormatSection(),
            const Gap(14),
            // ----------------------------------------------
            // SCAN BADGES
            // ----------------------------------------------
            _scanBadgeSection(context, nfcProv),
          ],
        ),
      ),
    );
  }

  Expanded _scanBadgeSection(BuildContext context, NFCProvider provider) {
    return Expanded(
      flex: 8,
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            // Tangkap karakter yang diinput
            final String key = event.logicalKey.keyLabel;
            // Periksa apakah key bukan kosong
            if (key.isNotEmpty) {
              provider.appendScannedData(key);
            }
            // Periksa jika NFC reader mengirimkan karakter seperti "Enter" (ID selesai dikirim)
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              // Proses data NFC yang sudah selesai
              provider.processScannedData(
                (scannedCard) async {
                  if (scannedCard.isNotEmpty ) {
                    await context
                        .read<AuthProvider>()
                        .loginWithCard(scannedCard);
                    
                  }
                },
              );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: _borderStyle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.icYourBadge),
              const Text(
                'Silahkan tap badge kamu disebelah layar!',
                style: AppStyles.title2Medium,
              ),
              const Text(
                'Agar bisa menggunakan cargo lift.',
                style: AppStyles.label2Regular,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _dateFormatSection() {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onDoubleTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: _borderStyle,
          child: Consumer<ClockProvider>(builder: (context, provClock, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  provClock.clockStr,
                  maxLines: 1,
                  style: AppStyles.heading1SemiBold,
                ),
                const Gap(12),
                AutoSizeText(
                  provClock.dateStr,
                  maxLines: 1,
                  style: AppStyles.title2Regular,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          CustomContainerButton(
            iconPath: SvgPicture.asset(AppIcons.icHistory),
            text: 'History',
            onTap: () {
              context.goNamed('history');
            },
          )
        ],
      ),
    );
  }
}

BoxDecoration get _borderStyle => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.grey.shade400),
    );
