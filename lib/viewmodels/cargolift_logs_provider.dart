import 'package:flutter/material.dart';

import '../models/lift_action_log.dart';
import '../services/lift_cargo_service.dart';
import '../services/locator.dart';
import '../services/shared_pref_services.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';
import '../shared/utils/helper_toast.dart';

class CargoLiftLogsProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _serviceLift = serviceLocator<LiftCargoService>();
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  List<LiftActionLog> historyLogLift = [];

  Future<bool> addHistory(String indicator) async {
    String uuid = _sharedPref.readSelectedLift;
    if (state.isLoading == false) {
      state = state.loading;
      notifyListeners();
    }

    var response =
        await _serviceLift.addLogActionLift(uuid: uuid, indicator: indicator);

    bool isSuccess = false;
    response.fold(
      (l) {
        isSuccess = false;
        ToastHelper.showCoolErrorToast(title: l.codeMsg, message: l.message);
        state = state.failed;
        notifyListeners();
      },
      (r) {
        isSuccess = true;
        state = state.loaded;
        notifyListeners();
      },
    );
    return isSuccess;
  }

  void getLogActions() async {
    String uuid = _sharedPref.readSelectedLift;
    if (state.isLoading == false) {
      state = state.loading;
      notifyListeners();
    }
    var response = await _serviceLift.getHistoryLift(uuid: uuid);
    response.fold(
      (l) {
        state = state.failed;
        notifyListeners();
      },
      (r) {
        historyLogLift.clear();
        historyLogLift.addAll(r);
        state = state.loaded;
        notifyListeners();
      },
    );
  }
}
