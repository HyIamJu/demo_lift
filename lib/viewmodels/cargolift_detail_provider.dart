import 'package:flutter/material.dart';

import '../models/lift_cargo_detail_model.dart';
import '../services/lift_cargo_service.dart';
import '../services/locator.dart';
import '../services/shared_pref_services.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';
import '../shared/utils/helper_toast.dart';

class LiftCargoDetailProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _service = serviceLocator<LiftCargoService>();
  final _sharedPref = serviceLocator<SharedPreferencesServices>();
  LiftCargoDetail? detailLift;

  void changeStatusLift(String status) {
    if (detailLift != null) {
      detailLift?.createdAt = DateTime.now().toString();
      detailLift?.cargoLiftButton = status;
      notifyListeners();
    }
  }

  Future<void> getDetailLift() async {
    String uuid = _sharedPref.readSelectedLift;
    detailLift = null;
    if (uuid.isEmpty) {
      ToastHelper.showCoolErrorToast(
          title: "Lift not selected", message: "Please set lift first!");
    } else {
      if (!state.isLoading) {
        state = state.loading;
        notifyListeners();
      }
      final result = await _service.cargoLiftDetail(uuid);
      result.fold(
        (l) {
          detailLift = null;
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
}
