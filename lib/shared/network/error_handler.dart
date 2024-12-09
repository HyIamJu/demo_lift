// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

import '../error/failure.dart';


class ErrorHandler implements Exception {
  late Failure failure;


// the reason why I adding message key because in
// fews api have diffrent key such as "msg", "message", "MESSAGE" etc.
  ErrorHandler.handle(dynamic error, {String messageKey = 'MESSAGE'}) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error, messageKey);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error, String messageKey ) {
  switch (error.type) {
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        switch (error.response?.statusCode) {
          case 400:
            if (error.response?.data[messageKey] == null) {
              return DataSource.BAD_REQUEST.getFailure();
            } else {
              return APIFailure(
                statusCode: error.response?.statusCode ?? 0,
                message: error.response?.data[messageKey] ?? "",
              );
            }
          case 401:
            return DataSource.UNAUTORISED.getFailure();
          case 403:
            return DataSource.FORBIDDEN.getFailure();
          case 404:
            return DataSource.NOT_FOUND.getFailure();
          case 500:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return const APIFailure(
          statusCode: ResponseCode.SUCCESS,
          message: "Success",
        );
      case DataSource.NO_CONTENT:
        return const APIFailure(
          statusCode: ResponseCode.NO_CONTENT,
          message: "No Content",
        );
      case DataSource.BAD_REQUEST:
        return const APIFailure(
          statusCode: ResponseCode.BAD_REQUEST,
          message: "Bad Request",
        );
      case DataSource.FORBIDDEN:
        return const APIFailure(
          statusCode: ResponseCode.FORBIDDEN,
          message: "Forbiden",
        );
      case DataSource.UNAUTORISED:
        return const APIFailure(
          statusCode: ResponseCode.UNAUTORISED,
          message: "Unauthorization",
        );
      case DataSource.NOT_FOUND:
        return const APIFailure(
          statusCode: ResponseCode.NOT_FOUND,
          message: "Not Found",
        );
      case DataSource.INTERNAL_SERVER_ERROR:
        return const APIFailure(
          statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
          message: "Internal Server Error",
        );
      case DataSource.CONNECT_TIMEOUT:
        return const APIFailure(
          statusCode: ResponseCode.CONNECT_TIMEOUT,
          message: "Connection Timeout",
        );
      case DataSource.CANCEL:
        return const APIFailure(
          statusCode: ResponseCode.CANCEL,
          message: "Canceled",
        );
      case DataSource.RECIEVE_TIMEOUT:
        return const APIFailure(
          statusCode: ResponseCode.RECIEVE_TIMEOUT,
          message: "Receive Timeout",
        );
      case DataSource.SEND_TIMEOUT:
        return const APIFailure(
          statusCode: ResponseCode.SEND_TIMEOUT,
          message: "Send Timeout",
        );
      case DataSource.CACHE_ERROR:
        return const APIFailure(
          statusCode: ResponseCode.CACHE_ERROR,
          message: "Cache Error",
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return const APIFailure(
          statusCode: ResponseCode.NO_INTERNET_CONNECTION,
          message: "Connection Error",
        );
      case DataSource.DEFAULT:
        return const APIFailure(
          statusCode: ResponseCode.DEFAULT,
          message: "Unknown Error",
        );
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

// class ResponseMessage {
//   static const String SUCCESS = LocaleKeys.success; // success with data
//   static const String NO_CONTENT = LocaleKeys.success; // success with no data (no content)
//   static const String BAD_REQUEST = LocaleKeys.badRequestError; // failure, API rejected request
//   static const String UNAUTORISED = LocaleKeys.unauthorizedError; // failure, user is not authorised
//   static const String FORBIDDEN = LocaleKeys.forbiddenError; //  failure, API rejected request
//   static const String INTERNAL_SERVER_ERROR = LocaleKeys.internalServerError; // failure, crash in server side
//   static const String NOT_FOUND = LocaleKeys.notFoundError; // failure, crash in server side

//   // local status code
//   static const String CONNECT_TIMEOUT = LocaleKeys.timeoutError;
//   static const String CANCEL = LocaleKeys.defaultError;
//   static const String RECIEVE_TIMEOUT = LocaleKeys.timeoutError;
//   static const String SEND_TIMEOUT = LocaleKeys.timeoutError;
//   static const String CACHE_ERROR = LocaleKeys.cacheError;
//   static const String NO_INTERNET_CONNECTION = LocaleKeys.noInternetError;
//   static const String DEFAULT = LocaleKeys.defaultError;
// }

class ApiInternalStatus {
  static const int SUCCESS = 200;
  static const int FAILURE = 400;
}
