import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../shared/extensions/context_extenstion.dart';
import '../../shared/finite_state.dart';
import '../../shared/network/generic_failure_message_widget.dart';
import '../../shared/network/generic_loading_widget.dart';
import '../../viewmodels/cargolift_list_provider.dart';

class MenuDialogSettings extends StatelessWidget {
  const MenuDialogSettings({super.key});

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
            Consumer<LiftCargoListProvider>(
              builder: (context, prov, _) {
                var state = prov.state;

                if (state.isLoading || state.isInitial) {
                  return const GenericCircleLoading();
                } else if (state.isFailed) {
                  return Center(
                    child: GenericFailureMessage(
                      onTap: () {
                        prov.getListCargoLift();
                      },
                      title: prov.failure?.codeMsg,
                      subText: prov.failure?.message,
                    ),
                  );
                } else if (state.isLoaded) {
                  return Column(
                    children: [
                      ...prov.listCargo.map(
                        (value) => _buildRadioListTile(
                          context,
                          title:
                              "${value.cargoLiftName ?? ""} - ${value.floorName ?? ""} - ${value.cargoLiftCode ?? ""}",
                          value: value.cargoLiftUuid ?? "",
                          providerList: prov,
                        ),
                      )
                      // ...options.map((option) => _buildRadioListTile(option)),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioListTile(
    BuildContext context, {
    required String title,
    required String value,
    required LiftCargoListProvider providerList,
  }) {
    return RadioListTile<String>(
      activeColor: AppColors.red,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppStyles.body1Regular,
      ),
      value: value,
      groupValue: providerList.groupValue,
      onChanged: (value) async {
        providerList.setGroupValue(uuid: value ?? "", name: title);
        Navigator.pop(context);

        // await _showDialogTapBadge(context);
      },
    );
  }

  // Future<void> _showDialogTapBadge(BuildContext context) async {
  Row _appBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Setting Current Lift', style: AppStyles.title2Medium),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
