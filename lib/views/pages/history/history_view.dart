import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_styles.dart';
import '../../../shared/extensions/context_extenstion.dart';
import '../../../shared/utils/date_formating.dart';
import '../../../widgets/datepicker_custom.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final bool isLogin = false;

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              children: [
                Text(
                  formatDateString(
                    _selectedDate.toString(),
                    toFormat: "dd MMMM yyyy",
                  ),
                  style: AppStyles.label2Medium,
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    showCustomDatePickerNormal(
                      context,
                      currentDate: _selectedDate,
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                    ).then((selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                    });
                  },
                  child: SvgPicture.asset(AppIcons.icCalender),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15,
                  ),
                ),
                const Text(
                  '1/2',
                  style: AppStyles.label2Regular,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                )
              ],
            ),
            _historyTable(context),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
        onPressed: () {
          if (isLogin) {
            context.goNamed('home');
          } else {
            context.goNamed('login');
          }
        },
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          size: 18,
        ),
      ),
      title: const Text(
        'History Status Lift Cargo Control',
        style: AppStyles.label1Medium,
      ),
    );
  }
}

Widget _historyTable(BuildContext context) {
  return Table(
    border: const TableBorder(
      horizontalInside: BorderSide.none,
      verticalInside: BorderSide.none,
      bottom: BorderSide.none,
    ),
    columnWidths: {
      0: FixedColumnWidth(context.fullWidth * 0.04),
      1: FixedColumnWidth(context.fullWidth * 0.53),
      2: FixedColumnWidth(context.fullWidth * 0.12),
      3: FixedColumnWidth(context.fullWidth * 0.1),
    },
    children: [
      TableRow(
        decoration:
            BoxDecoration(color: Colors.grey.shade300.withOpacity(0.25)),
        children: [
          _buildTableHeaderCell('No'),
          _buildTableHeaderCell('Employee Name'),
          _buildTableHeaderCell('Status'),
          _buildTableHeaderCell('Location'),
          _buildTableHeaderCell('Date'),
        ],
      ),
      TableRow(
        decoration: _underLine,
        children: [
          _buildTableCell('1'),
          _buildTableCellWithAvatar(
            'Franklin Lim (29182915)',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPUNjiFBSAEiCYZl0XHhfYc7jWxVPQMOJjwQ&s',
          ),
          _buildTableCell('F1 to F3'),
          _buildTableCell('LT.1 SMT'),
          _buildTableCell('26 Nov 2024, 11:10'),
        ],
      ),
      TableRow(
        decoration: _underLine,
        children: [
          _buildTableCell('2'),
          _buildTableCellWithAvatar(
            'Muhammad Chandra Pratama  (29182915)',
            'https://i.mydramalist.com/RBk6gg_5c.jpg',
          ),
          _buildTableCell('EMERGENCY'),
          _buildTableCell('LT.1 SMT'),
          _buildTableCell('26 Nov 2024, 11:10'),
        ],
      ),
    ],
  );
}

Widget _buildTableHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Text(
      text,
      style: AppStyles.body2Medium,
    ),
  );
}

Widget _buildTableCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Text(
      text,
      style: AppStyles.body2Regular,
    ),
  );
}

Widget _buildTableCellWithAvatar(
  String text,
  String imgpath,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            shadows: [BoxShadow(spreadRadius: 1, color: AppColors.grey)],
          ),
          child: Image.network(
            imgpath,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(8),
        Text(
          text,
          style: AppStyles.body2Regular,
        ),
      ],
    ),
  );
}

BoxDecoration get _underLine => BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade500.withOpacity(0.5),
        ),
      ),
    );
