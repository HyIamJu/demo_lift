import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../shared/extensions/context_extenstion.dart';
import 'success_dialog.dart';

class MenuDialogSettings extends StatefulWidget {
  const MenuDialogSettings({super.key});

  @override
  _MenuDialogSettingsState createState() => _MenuDialogSettingsState();
}

class _MenuDialogSettingsState extends State<MenuDialogSettings> {
  int _selectedOption = 0;

  final List<Map<String, dynamic>> options = [
    {'value': 1, 'title': 'SMT-CRG-LT-001'},
    {'value': 2, 'title': 'SMT-CRG-LT-002'},
    {'value': 3, 'title': 'SMT-CRG-LT-003'},
    {'value': 4, 'title': 'SMT-CRG-LT-001'},
    {'value': 5, 'title': 'SMT-CRG-LT-002'},
    {'value': 6, 'title': 'SMT-CRG-LT-003'},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: context.fullWidth * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(context),
            const Gap(12),
            const Divider(),
            ...options.map((option) => _buildRadioListTile(option)),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioListTile(Map<String, dynamic> option) {
    return RadioListTile<int>(
      activeColor: AppColors.red,
      contentPadding: EdgeInsets.zero,
      title: Text(
        option['title'],
        style: AppStyles.body1Regular,
      ),
      value: option['value'],
      groupValue: _selectedOption,
      onChanged: (value) async {
        setState(() {
          _selectedOption = value!;
        });

        Navigator.pop(context);

        await _showDialogTapBadge(context);
      },
    );
  }

  Future<void> _showDialogTapBadge(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            Navigator.pop(context);
            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                showDialogSuccess(context, miliseconds: 2000);
              },
            );
          },
          child: AlertDialog(
            backgroundColor: AppColors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIcons.icYourBadge,
                  width: 100,
                  height: 100,
                ),
                const Gap(16),
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
        );
      },
    );
  }

  Row _appBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Setting', style: AppStyles.title2Medium),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
