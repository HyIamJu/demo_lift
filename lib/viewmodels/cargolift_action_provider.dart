import 'package:flutter/material.dart';

import '../services/lift_action_services.dart';
import '../services/locator.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';
import '../shared/utils/helper_toast.dart';

class LiftActionProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  final _service = serviceLocator<LiftActionServices>();
  


  Future<bool> liftUp() async {
    state = state.loading;
    notifyListeners();
    final resultHold = await _service.holdLift();

    bool finalResultUp = false;

    resultHold.fold(
      (l) {
        finalResultUp = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
      },
      (r) async {
        await Future.delayed(const Duration(milliseconds: 1500));
        final goUp = await _service.upLift();
        goUp.fold(
          (l) {
            finalResultUp = false;
            state = state.failed;
            notifyListeners();
            ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
          },
          (r) {
            finalResultUp = true;
            state = state.loaded;
            notifyListeners();
          },
        );
      },
    );

    return finalResultUp;
  }

  Future<bool> liftDown() async {
    state = state.loading;
    notifyListeners();
    final reponseHold = await _service.holdLift();
    bool finalResultDown = false;

    reponseHold.fold(
      (l) {
        finalResultDown = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
      },
      (r) async {
        await Future.delayed(const Duration(milliseconds: 1500));
        final responseUp = await _service.downLift();
        responseUp.fold(
          (l) {
            finalResultDown = false;
            state = state.failed;
            notifyListeners();
            ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
          },
          (r) {
            finalResultDown = true;
            state = state.loaded;
            notifyListeners();
          },
        );
      },
    );
    return finalResultDown;
  }

  Future<bool> liftHold() async {
    state = state.loading;
    notifyListeners();
    final response = await _service.holdLift();

    bool result = false;
    response.fold(
      (l) {
        result = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
      },
      (r) {
        result = true;
        state = state.loaded;
        notifyListeners();
      },
    );
    return result;
  }

  Future<bool> emergencyStop() async {
    state = state.loading;
    notifyListeners();
    final response = await _service.emergency();

    bool result = false;
    response.fold(
      (l) {
        result = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(title: "Local Service Error", message: l.message);
      },
      (r) {
        result = true;
        state = state.loaded;
        notifyListeners();
      },
    );
    return result;
  }
}
