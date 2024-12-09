import '../constants/typedef_app.dart';
import '../models/lift_action_log.dart';
import '../models/lift_cargo_detail_model.dart';
import '../models/lift_cargo_model.dart';
import '../repositories/lift_cargo_repository.dart';

class LiftCargoService {
  final LiftCargoRepository liftCargoRepository;
  LiftCargoService(this.liftCargoRepository);

  ResultFuture<LiftCargoDetail> cargoLiftDetail(String cargoLiftUuid) async =>
      await liftCargoRepository.cargoLiftDetail(cargoLiftUuid);

  ResultFuture<List<LiftCargoModel>> cargoLiftList() async =>
      await liftCargoRepository.cargoLiftList();

  ResultFuture<bool> addLogActionLift({
    required String uuid,
    required String indicator,
  }) async =>
      await liftCargoRepository.cargoLiftAddLog(
        indicator: indicator,
        uuidCargo: uuid,
      );
  ResultFuture<List<LiftActionLog>> getHistoryLift({
    required String uuid,
  }) async =>
      await liftCargoRepository.cargoLiftListHistory(
        uuidCargo: uuid,
      );
}
