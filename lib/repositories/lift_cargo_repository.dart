import 'package:dartz/dartz.dart';
import '../constants/app_configs.dart';
import '../constants/typedef_app.dart';
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
          "uuid_cargo": "a2ab5535-1076-466a-96e8-0d6865faa3e8",
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
}
