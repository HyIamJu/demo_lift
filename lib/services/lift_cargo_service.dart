import '../constants/typedef_app.dart';
import '../models/lift_cargo_detail_model.dart';
import '../models/lift_cargo_model.dart';
import '../repositories/lift_cargo_repository.dart';

class LiftCargoService {
  final LiftCargoRepository liftCargoRepository;
  LiftCargoService(this.liftCargoRepository);

  ResultFuture<LiftCargoDetail> cargoLiftDetail(String cargoLiftUuid) async {
    return await liftCargoRepository.cargoLiftDetail(cargoLiftUuid);
  }

  ResultFuture<List<LiftCargoModel>> cargoLiftList() async {
    return await liftCargoRepository.cargoLiftList();
  }
}
