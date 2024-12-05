import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'viewmodels/auth_provider.dart';
import 'package:provider/provider.dart';
import 'services/locator.dart';
import 'viewmodels/Nfc_scanner_provider.dart';
import 'viewmodels/clock_provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = serviceLocator<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClockProvider()..startTimerClock(),
          lazy: true,
        ),
        ChangeNotifierProvider(create: (_) => NFCProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(

        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        title: 'Lift Cargo Control',
        builder: EasyLoading.init(
          builder: (_, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(
                    minScaleFactor: 1,
                    maxScaleFactor: 1,
                  ),
            ),
            child: child!,
          ),
        ),
      ),
    );
  }
}
