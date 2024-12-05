import '../repositories/lift_cargo_repository.dart';
import '../constants/typedef_app.dart';

class LiftCargoService {
  final LiftCargoRepository liftCargoRepository;
  LiftCargoService(this.liftCargoRepository);

  ResultFuture<String> cargoLiftDetail(String cargoLift) async {
    return await liftCargoRepository.cargoLiftDetail(cargoLift);
  }

  ResultFuture<String> cargoLiftList() async {
    return await liftCargoRepository.cargoLiftList();
  }
}
