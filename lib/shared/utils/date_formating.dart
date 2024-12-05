import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Fungsi untuk memformat tanggal dari string ke format yang diinginkan.
///
/// Contoh string input yang diterima (ISO-8601):
/// - "2012-02-27"
/// - "2012-02-27 13:27:00"
/// - "2012-02-27T14+00:00"
///
/// Jika format input berbeda, gunakan parameter [fromFormat] untuk menyesuaikan format.
///
/// [dateString] : String tanggal input.
/// [fromFormat] : Format input (opsional, default ISO-8601).
/// [toFormat] : Format output yang diinginkan (wajib diisi).
/// [initialLocale] : Locale untuk parsing tanggal input (default 'id').
/// [outputLocale] : Locale untuk format output (default 'id').
///
/// Jika parsing gagal, fungsi akan mengembalikan string input tanpa perubahan.
String formatDateString(
  String dateString, {
  String fromFormat = "",
  required String toFormat,
  String initialLocale = 'id',
  String outputLocale = 'id',
}) {
  try {
    // Parsing string ke DateTime berdasarkan format input
    DateTime parsedDate;
    if (fromFormat.isEmpty) {
      // Jika tidak ada format input, gunakan parsing default (ISO-8601)
      parsedDate = DateTime.parse(dateString);
    } else {
      // Parsing dengan format input khusus
      parsedDate = DateFormat(fromFormat, initialLocale).parse(dateString);
    }

    // Format DateTime ke string output berdasarkan format yang diinginkan
    return DateFormat(toFormat, outputLocale).format(parsedDate);
  } catch (e) {
    // Jika parsing gagal, kembalikan string input
    debugPrint("Error parsing date: $e");
    return dateString;
  }
}

String formatDateTime(
  DateTime dateTime, {
  required String toFormat,
  String initialLocale = 'id',
  String outputLocale = 'id',
}) {
  try {
    // Format DateTime ke string output berdasarkan format yang diinginkan
    return DateFormat(toFormat, outputLocale).format(dateTime);
  } catch (e) {
    // Jika parsing gagal, kembalikan string input
    debugPrint("Error parsing date: $e");
    return dateTime.toString();
  }
}
