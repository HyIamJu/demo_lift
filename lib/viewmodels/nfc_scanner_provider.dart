import 'dart:async';

import 'package:flutter/material.dart';

// Provider untuk menangani pemrosesan data NFC
class NFCProvider extends ChangeNotifier {
  // Data yang di-scan sementara
  String _scannedData = "";

  // Kata-kata atau karakter yang ingin dibersihkan dari hasil scan
List<String> _excludedKeywords = [
  // Variasi kata "enter"
  "enter",
  "ENTER",
  "Enter",
  "\n", // Baris baru
  "\r", // Carriage return
  
  // Kata-kata umum yang tidak relevan
  "capslock",
  "CAPSLOCK",
  "Capslock",
  "shift",
  "SHIFT",
  "Shift",
  "space",
  "SPACE",
  "Space",
  // Spasi berlebih
  "  ", // Double space (dua spasi berturut-turut)
  "\t", // Tabulasi
];

  // Timer untuk debouncing
  Timer? _debounceTimer;

  // Callback untuk memberikan hasil setelah pemrosesan
  Function(String)? onDataProcessed;

  // Mendapatkan data yang sudah discan
  String get scannedData => _scannedData;

  // Mengatur kata-kata yang akan dihapus dari hasil scan
  void setExcludedKeywords(List<String> keywords) {
    _excludedKeywords = keywords;
  }

  /// Menambahkan karakter ke hasil scan dan menangani debouncing.
  void appendScannedData(String key) {
    _scannedData += key;

    // Restart debounce timer setiap ada karakter baru
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    // // Menunggu sebentar 300ms sebelum memproses data
    // _debounceTimer = Timer(Durations.medium2, () {
    //   processScannedData();
    // });

    notifyListeners();
  }

  /// Membersihkan data dari karakter atau kata yang tidak diinginkan.
  String _cleanScannedData(String data) {
    // Menghapus karakter non-alfanumerik menggunakan regex
    String cleanedData = data.replaceAll(RegExp(r'[\W_]+'), '');

    // Menghapus kata-kata yang ada dalam daftar excludedKeywords
    for (var keyword in _excludedKeywords) {
      cleanedData = cleanedData.replaceAll(keyword, '');
    }

    return cleanedData;
  }

  /// Memproses data yang sudah discan dengan callback yang diterima sebagai parameter.
  void processScannedData(void Function(String value) dataProcessor) {
    String cleanedData = _cleanScannedData(_scannedData);

    // Mengirim hasil pemrosesan melalui callback yang diberikan
    dataProcessor(cleanedData);

    // Reset data scan setelah diproses
    resetScannedData();
  }

  /// Mengatur ulang data scan.
  void resetScannedData() {
    _scannedData = "";
    notifyListeners();
  }
}
