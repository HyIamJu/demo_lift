import 'package:dartz/dartz.dart';

import '../constants/typedef_app.dart';
import '../services/http_client.dart';
import '../shared/network/error_handler.dart';

class LiftActionRepository {
  final HttpClient httpClient;

  LiftActionRepository(this.httpClient);

  ResultFuture<bool> goUp() async {
    try {
      await httpClient.localClient.post(
        '/control',
        data: {"pin": 1},
      );
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<bool> goDown() async {
    try {
      await httpClient.localClient.post(
        '/control',
        data: {"pin": 2},
      );
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<bool> hold() async {
    try {
      await httpClient.localClient.post(
        '/control',
        data: {"pin": 3},
      );
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<bool> emergency() async {
    try {
      await httpClient.localClient.post(
        '/control',
        data: {"pin": 4},
      );
      return const Right(true);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
