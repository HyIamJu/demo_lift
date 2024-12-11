import '../constants/typedef_app.dart';
import '../repositories/lift_action_repository.dart';

class LiftActionServices {
  final LiftActionRepository actionLiftRepository;
  LiftActionServices(this.actionLiftRepository);
  
  ResultFuture<bool> upLift() async => await actionLiftRepository.goUp();
  ResultFuture<bool> downLift() async => await actionLiftRepository.goDown();
  ResultFuture<bool> holdLift() async => await actionLiftRepository.hold();
  ResultFuture<bool> emergencyStart() async => await actionLiftRepository.emergencyStart();
  ResultFuture<bool> emergencyStop() async => await actionLiftRepository.emergencyStop();
}
