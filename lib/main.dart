import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await initializeDateFormatting('id', null);

  // Set fullscreen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ----------------------------------------------
  // window manager setup
  // ----------------------------------------------

  // Inisialisasi window manager
  await windowManager.ensureInitialized();

  // Set window options
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1920, 1080), // Ukuran layar penuh
    center: true,
    backgroundColor: Colors.transparent,
    title: 'Kiosk Mode',
    fullScreen: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setFullScreen(true); // Paksa fullscreen
    await windowManager.setAlwaysOnTop(true); // Pastikan selalu di atas
    await windowManager.show();
  });
  runApp(MyApp());
}
