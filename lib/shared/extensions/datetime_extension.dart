import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Cek apakah tanggal adalah hari kerja (bukan Sabtu atau Minggu)
  bool get isWeekday {
    final dayOfWeek = DateFormat('EEEE').format(this);
    return (dayOfWeek != 'Saturday' && dayOfWeek != 'Sunday') || (dayOfWeek != 'Sabtu' && dayOfWeek != 'Minggu');
  }

  /// Cek apakah waktu berada dalam jam kerja (06:00 hingga 17:30)
  bool get isWorkingHours {
    final hour = this.hour;
    final minute = this.minute;
    return (hour >= 6 && (hour < 17 || (hour == 17 && minute <= 30)));
  }
}