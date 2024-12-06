import 'package:dartz/dartz.dart';

import '../constants/typedef_app.dart';
import '../services/http_client.dart';
import '../shared/network/error_handler.dart';

class AuthRepository {
  final HttpClient httpClient;
  AuthRepository(this.httpClient);

  ResultFuture<Map<String, dynamic>> login(String cardId, String cargoUuid) async {
    try {
      final response = await httpClient.basicClient.post(
        '/cargoLift/loginCardNo',
        data: {
          // 'card_no': cardId,
          // 'secret_key': "a2ab5535-1076-466a-96e8-0d6865faa3e8", // uuid dari cargo nya
          'card_no': "3700691047",
          'secret_key': cargoUuid, // uuid dari cargo nya
        },
      );

      Map<String, dynamic> data = response.data;
      // Jika berhasil, return Right dengan data User
      return Right(data);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e, messageKey: "MESSAGE").failure);
    }
  }

  ResultFuture<bool> logout() async {
    try {
      await httpClient.authClient.post("/v2/logout");
      return const Right(true);
    } catch (e) {
      // Tangani error jika terjadi masalah dengan API
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
