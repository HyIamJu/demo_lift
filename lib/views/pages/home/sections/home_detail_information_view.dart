import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_styles.dart';
import '../../../../shared/utils/date_formating.dart';
import '../../../../viewmodels/auth_provider.dart';
import '../../../../widgets/custom_row_list.dart';

class HomeDetailInformationView extends StatelessWidget {
  final String liftStatus;
  final int flex;

  const HomeDetailInformationView({
    super.key,
    required this.liftStatus,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: _borderStyle,
          // alasan pake listview karna biar engga overflow abangkuh kalau ditab kicik
          child: Consumer<AuthProvider>(
            builder: (context, prov, _) {
              var data = prov.user;

              return ListView(
                children: [
                  // ----------------------------------------------
                  // Detail information employee
                  // ----------------------------------------------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          data?.employeeImage ?? "",
                          width: 180,
                          height: 260,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(4),
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.icPersonEmployee),
                                const Gap(4),
                                const Flexible(
                                  child: Text(
                                    'Detail Information Employee',
                                    style: AppStyles.title1Medium,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              data?.employeeName ?? "",
                              style: AppStyles.title1SemiBold,
                            ),
                            const Gap(10),
                            const Text(
                              'Store',
                              style: AppStyles.title2Regular,
                            ),
                            CustomRowList(
                              name: 'No Badge',
                              nameTextStyle: AppStyles.label1SemiBold,
                              nameFlex: 2,
                              desc: "${data?.employeeBadge}",
                              descFlex: 4,
                              descTextStyle: AppStyles.title2Regular,
                            ),
                            CustomRowList(
                              name: 'DIV',
                              nameFlex: 2,
                              nameTextStyle: AppStyles.label1SemiBold,
                              desc: "${data?.departmentCode}",
                              descFlex: 4,
                              descTextStyle: AppStyles.title2Regular,
                            ),
                            CustomRowList(
                              name: 'Dept',
                              nameFlex: 2,
                              nameTextStyle: AppStyles.label1SemiBold,
                              desc: "${data?.departmentName}",
                              descFlex: 4,
                              descTextStyle: AppStyles.title2Regular,
                            ),
                            CustomRowList(
                              name: 'Line Code',
                              nameFlex: 2,
                              nameTextStyle: AppStyles.label1SemiBold,
                              desc: "${data?.lineCode}",
                              descFlex: 4,
                              descTextStyle: AppStyles.title2Regular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  const Divider(),
                  const Gap(8),
                  // ----------------------------------------------
                  // Detail Information Lift Cargo Control
                  // ----------------------------------------------
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.icDetailInformation),
                      const Gap(6),
                      const Flexible(
                        child: Text(
                          'Detail Information Lift Cargo Control',
                          style: AppStyles.title1Medium,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  const CustomRowList(
                    name: 'Location',
                    nameFlex: 2,
                    nameTextStyle: AppStyles.label1SemiBold,
                    desc: 'Cargo 1',
                    descFlex: 5,
                    descTextStyle: AppStyles.title2Regular,
                  ),
                  const Gap(8),
                  CustomRowList(
                    name: 'Status',
                    nameFlex: 2,
                    nameTextStyle: AppStyles.label1SemiBold,
                    desc: liftStatus,
                    descTextStyle: AppStyles.label2SemiBold,
                    descFlex: 5,
                  ),
                  const Gap(8),
                  CustomRowList(
                    name: 'Date Time',
                    nameFlex: 2,
                    nameTextStyle: AppStyles.label1SemiBold,
                    desc: formatDateString(DateTime.now().toString(),
                        toFormat: 'dd MMMM yyyy, HH:mm'),
                    descFlex: 5,
                    descTextStyle: AppStyles.title2Regular,
                  ),
                ],
              );
            },
          )),
    );
  }
}

BoxDecoration get _borderStyle => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.grey.shade400),
    );
