import 'dart:async';

import 'package:flutter/material.dart';

import '../shared/utils/date_formating.dart';

class ClockProvider extends ChangeNotifier {
  DateTime date = DateTime.now();

  // outputnya 11.00 WIB
  String get clockStr => formatDateTime(date, toFormat: "HH.mm");
  // outputnya Kamis, 25 Aug 2024
  String get dateClockStr => formatDateTime(date, toFormat: "dd MMMM yyyy, HH.mm");
  // outputnya 25 Aug 2023
  String get dateStr => formatDateTime(date, toFormat: "dd MMMM yyyy");

  // ----------------------------------------------
  // untuk sekarang pakau ticker saja masih cukup
  // ----------------------------------------------
  late Timer _timer;

  void startTimerClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      date = DateTime.now();
      notifyListeners();
      // debugPrint("date : $date");
    });
  }

  void stopTimerClock() {
    _timer.cancel();
  }

  // ----------------------------------------------
  // Suatu saat kalau pengen stream pake func ini aja
  // ----------------------------------------------
  // late StreamSubscription<DateTime> _clockSubscription;
  // void startStreamClock() {
  //   _clockSubscription = currentUpdatedTime().listen(
  //     (currentDate) {
  //       date = currentDate;
  //       notifyListeners();
  //     },
  //   );
  // }
  // void stopStreamClock() {
  //   _clockSubscription.cancel();
  // }
  // Stream<DateTime> currentUpdatedTime() async* {
  //   while (true) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     print(DateTime.now().toString());
  //     yield DateTime.now();
  //   }
  // }
}
