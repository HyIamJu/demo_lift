import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

Future<DateTime> showCustomDatePickerNormal(
  BuildContext context, {
  required DateTime currentDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  List<DateTime?> dates = [currentDate];
  List<DateTime?> newTime = await showCalendarDatePicker2Dialog(
        dialogBackgroundColor: AppColors.white,
        context: context,
        config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.single,
            currentDate: DateTime.now(),
            lastDate: lastDate,
            firstDate: firstDate,
            selectedDayHighlightColor: AppColors.red,
            okButton: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.red),
              child: Text(
                'OK',
                style: AppStyles.body2Medium.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
            cancelButtonTextStyle:
                AppStyles.body2Medium.copyWith(color: AppColors.red)),
        dialogSize: const Size(325, 400),
        value: dates,
        borderRadius: BorderRadius.circular(15),
      ) ??
      [];

  // ---- //
  if (newTime.isNotEmpty) {
    dates = newTime;
    if (dates.isNotEmpty && (dates.first != null)) {
      return dates.first!;
    }
  }
  return currentDate;
}
