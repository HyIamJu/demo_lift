import 'package:flutter/material.dart';

import '../models/lift_cargo_detail_model.dart';
import '../services/lift_cargo_service.dart';
import '../services/locator.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';

class LiftCargoDetailProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _service = serviceLocator<LiftCargoService>();
  LiftCargoDetail? detailLift;

  Future<void> getDetailLift() async {
    if (!state.isLoading) {
      state = state.loading;
      notifyListeners();
    }
    final result = await _service.cargoLiftDetail("123");
    result.fold(
      (l) {
        failure = l;
        state = state.failed;
        notifyListeners();
      },
      (r) {
        detailLift = r;
        state = state.loaded;
        notifyListeners();
      },
    );
  }
}
