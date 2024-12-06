import 'package:flutter/material.dart';
import '../models/lift_cargo_model.dart';
import '../services/lift_cargo_service.dart';
import '../services/locator.dart';
import '../services/shared_pref_services.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';

class LiftCargoListProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _service = serviceLocator<LiftCargoService>();

  List<LiftCargoModel> listCargo = [];
  String groupValue = "Empty";
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  Future<void> getListCargoLift() async {
    groupValue = _sharedPref.readSelectedLift;

    if (!state.isLoading) {
      state = state.loading;
      notifyListeners();
    }
    final result = await _service.cargoLiftList();

    result.fold(
      (l) {
        failure = l;
        state = state.failed;
        notifyListeners();
      },
      (r) {
        listCargo = r;
        state = state.loaded;
        notifyListeners();
      },
    );
  }

  set setGroupValue(String newValue) {
    groupValue = newValue;
    _sharedPref.saveLiftSelected(newValue);
    notifyListeners();
  }
}
