import 'package:flutter/material.dart';
import '../services/lift_cargo_service.dart';

import '../models/lift_cargo_detail_model.dart';
import '../services/locator.dart';
import '../services/shared_pref_services.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';

class LiftCargoDetailProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _service = serviceLocator<LiftCargoService>();
  LiftCargoDetail? detailLift;

  final _sharedPref = serviceLocator<SharedPreferencesServices>();

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
