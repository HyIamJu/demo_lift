import 'package:dartz/dartz.dart';
import '../constants/typedef_app.dart';
import '../services/http_client.dart';
import '../shared/network/error_handler.dart';

class LiftCargoRepository {
  final HttpClient httpClient;

  LiftCargoRepository(this.httpClient);

  ResultFuture<String> cargoLiftList() async {
    try {
      final response = await httpClient.basicClient.post(
        '/cargoLift/allCargoList',
      );

      String? token = response.data["TOKEN"];
      // Jika berhasil, return Right dengan data User
      return Right(token ?? "");
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  ResultFuture<String> cargoLiftDetail( String uuidCargo) async {
    try {
      final response = await httpClient.basicClient.post(
        '/cargoLift/cargoLiftDetail',
        data: {
          "uuid_cargo": "a2ab5535-1076-466a-96e8-0d6865faa3e8",
        },
      );

      String? token = response.data["TOKEN"];
      // Jika berhasil, return Right dengan data User
      return Right(token ?? "");
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
