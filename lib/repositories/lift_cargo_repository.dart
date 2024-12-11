import 'package:dartz/dartz.dart';

import '../constants/app_configs.dart';
import '../constants/typedef_app.dart';
import '../models/lift_action_log.dart';
import '../models/lift_cargo_detail_model.dart';
import '../models/lift_cargo_model.dart';
import '../services/http_client.dart';
import '../shared/network/error_handler.dart';

class LiftCargoRepository {
  final HttpClient httpClient;

  LiftCargoRepository(this.httpClient);

  ResultFuture<List<LiftCargoModel>> cargoLiftList() async {
    try {
      final response = await httpClient.basicClient.get(
        '/cargoLift/allCargoList',
        queryParameters: {
          "secret_key": AppConfigs.secretKey,
        },
      );

      // Jika berhasil, return Right dengan data User
      List<LiftCargoModel> listCargo = response.data["DATA"] == null
          ? []
          : List<LiftCargoModel>.from(
              response.data["DATA"]!.map(
                (x) => LiftCargoModel.fromMap(x),
              ),
            );

      return Right(listCargo);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<LiftCargoDetail> cargoLiftDetail(String uuidCargo) async {
    try {
      final response = await httpClient.authClient.get(
        '/cargoLift/cargoLiftDetail',
        queryParameters: {
          "uuid_cargo": uuidCargo,
        },
      );

      final detailLift = LiftCargoDetail.fromMap(response.data['DATA']);
      // Jika berhasil, return Right dengan data User
      return Right(detailLift);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<bool> cargoLiftAddLog(
      {required String uuidCargo, required String indicator}) async {
    try {
      await httpClient.authClient.post(
        '/cargoLift/ActionCargo',
        queryParameters: {
          "uuid_cargo": uuidCargo,
          "indicator": indicator //UP, HOLD, DOWN
        },
      );

      // Jika berhasil, return Right dengan data User
      return const Right(true);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<List<LiftActionLog>> cargoLiftListHistory(
      {required String uuidCargo}) async {
    try {
      final response = await httpClient.basicClient.get(
        '/cargoLift/cargoHistory',
        queryParameters: {
          "secret_key": AppConfigs.secretKey,
          "uuid_cargo": uuidCargo,
        },
      );

      // Jika berhasil, return Right dengan data User
      List<LiftActionLog> listActionCargo = response.data["DATA"] == null
          ? []
          : List<LiftActionLog>.from(
              response.data["DATA"]!.map(
                (x) => LiftActionLog.fromMap(x),
              ),
            );

      return Right(listActionCargo);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
