import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/app_configs.dart';
// import '../shared/navigator_keys.dart';
import '../views/dialogs/app_dialog.dart';
import 'locator.dart';
import 'shared_pref_services.dart';

final _sharedPrefService = serviceLocator<SharedPreferencesServices>();
// final _authService = serviceLocator<AuthService>();

class HttpClient {
  HttpClient._internal();
  static final _singleton = HttpClient._internal();
  factory HttpClient() => _singleton;

  final authClient = createDioAuth();

  final basicClient = createBasicDio();
  static const requestTimeOut = Duration(seconds: 15);

  Future<String> getBadge() async {
    return _sharedPrefService.readUser;
  }

  static Dio createBasicDio() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: requestTimeOut,
        baseUrl: AppConfigs.baseUrl,
      ),
    );

    dio.interceptors.addAll({
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        compact: true,
        responseBody: true,
      ),
    });

    return dio;
  }

  static Dio createDioAuth() {
    var dio = Dio(BaseOptions(
      connectTimeout: requestTimeOut,
      baseUrl: AppConfigs.baseUrl,
    ));

    dio.interceptors.addAll({
      AuthInterceptor(dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        compact: true,
        responseBody: true,
      ),
    });
    return dio;
  }
}

class LogWithToastInterceptor extends Interceptor {
  final Dio dio;
  LogWithToastInterceptor(this.dio);
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      AppDialog.toastSuccess("sucess ${response.requestOptions.path}");
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    AppDialog.dialogError(
      message:
          "Url : ${err.requestOptions.path} \nError ${response?.statusCode}: message ${response?.data['message']}",
      duration: const Duration(seconds: 5),
    );
    return handler.next(err);
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;
  AuthInterceptor(this.dio);

  bool _isRefreshing = false;

  DateTime? _timeStampLastRefreshToken;

  bool get _isRefreshStateExpired {
    if (_timeStampLastRefreshToken == null) {
      return false;
    } else {
      DateTime newTimeStamp = DateTime.timestamp();
      Duration difference =
          newTimeStamp.difference(_timeStampLastRefreshToken!);

      if (difference.inSeconds > 4) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = _sharedPrefService.readToken;
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    if (response != null &&
        response.statusCode == 401 &&
        response.requestOptions.path != "/v2/refreshToken") {
      if (_isRefreshing && _isRefreshStateExpired) {
        _isRefreshing = false;
        _timeStampLastRefreshToken = null;
      }

      if (!_isRefreshing) {
        _isRefreshing = true;
        _timeStampLastRefreshToken = DateTime.timestamp();

        final isRefreshSuccess = await _refreshToken();

        if (isRefreshSuccess) {
          _isRefreshing = false;
        } else {
          AppDialog.dialogError(
              message: "Sesi anda telah habis, silahkan login kembali");
          _forceLogout();
        }
      } else {}
    } else {
      return handler.next(err);
    }

    return handler.next(err);
  }

  void clearAllData() {
    // clear all data cache
    _sharedPrefService.clearAll();
  }

  void _forceLogout() async {
    _sharedPrefService.clearAll();

    // force logout
    // navigatorKey.currentState?.pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => const LoginView()),
    //   (route) => false,
    // );
  }

  Future<bool> _refreshToken() async {
    // final result = await _authService.refreshToken();

    // bool isSuccess = false;
    // result.fold(
    //   (failure) {
    //     isSuccess = false;
    //   },
    //   (newToken) {
    //     _sharedPrefService.saveToken(newToken ?? "");
    //     isSuccess = true;
    //   },
    // );
    // return isSuccess;
    return true;
  }
}
