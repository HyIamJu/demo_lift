import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../repositories/auth_repository.dart';
import '../router/app_router.dart';
import '../services/http_client.dart';
import '../services/shared_pref_services.dart';
import 'auth_service.dart';

final serviceLocator = GetIt.instance;

// ----------------------------------------------
// ini untuk penyimpan name saja, sehingga nanti
// text bisa konsisten dan tidak typo harus diketik
// ----------------------------------------------
class GetItInstanceName {
  static const String basicClient = 'basicClient';
  static const String authClient = 'authClient';
}

// ----------------------------------------------
// setup register service locator nya
// ----------------------------------------------
Future<void> setupServiceLocator() async {
  // Register sharedpreferance services
  final sharedPreferencesService =
      await SharedPreferencesServices.getInstance();
  serviceLocator.registerSingleton(sharedPreferencesService);
  serviceLocator.registerSingleton<HttpClient>(HttpClient());

  // Register Dio instances
  serviceLocator.registerSingleton<Dio>(HttpClient.createBasicDio(), instanceName: GetItInstanceName.basicClient);
  serviceLocator.registerSingleton<Dio>(HttpClient.createDioAuth(), instanceName: GetItInstanceName.authClient);

  // Register GoRouter instance
  final goRouter = createRouter(); // Panggil fungsi `createRouter`
  serviceLocator.registerSingleton<GoRouter>(goRouter);

  // register auth service
  serviceLocator.registerSingleton<AuthRepository>(AuthRepository(serviceLocator()));
  serviceLocator.registerSingleton<AuthService>(AuthService(serviceLocator()));

  // register meeting service
  // serviceLocator.registerSingleton<MeetingRepository>(MeetingRepository(serviceLocator()));
  // serviceLocator.registerSingleton<MeetingServices>(MeetingServices(serviceLocator()));
}
