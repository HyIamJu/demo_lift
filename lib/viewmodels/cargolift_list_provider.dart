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
  String nameLift = "";
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  initializeLiftCargoList() {
    groupValue = _sharedPref.readSelectedLift;
    nameLift = _sharedPref.readSelectedNameLift;
    notifyListeners();
  }

  Future<void> getListCargoLift() async {
    state = state.loading;
    notifyListeners();

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

  void setGroupValue({required String uuid, required String name}) {
    groupValue = uuid;
    _sharedPref.saveLiftSelected(uuid);
    nameLift = name;
    _sharedPref.saveNameLiftSelected(name);
    notifyListeners();
  }
}
