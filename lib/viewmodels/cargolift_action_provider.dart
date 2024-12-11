import 'package:flutter/material.dart';

import '../constants/app_configs.dart';
import '../services/lift_action_services.dart';
import '../services/locator.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';
import '../shared/utils/helper_toast.dart';

class LiftActionProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  bool isEmergencyActive = false;
  final _service = serviceLocator<LiftActionServices>();

  DateTime _timeStampLastAction = DateTime.now();

  void renewTimeStamp() {
    _timeStampLastAction = DateTime.now();
  }

  bool isSessionExpired() {
    int maxDifferenceInvalid = AppConfigs.timeOutSession; 
    var now = DateTime.now();
    final difference = _timeStampLastAction.difference(now).inSeconds.abs();
    return difference > maxDifferenceInvalid;
  }

  Future<bool> liftUp() async {
    state = state.loading;
    notifyListeners();

    bool finalResultUp = false;
    final goUp = await _service.upLift();
    goUp.fold(
      (l) {
        finalResultUp = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(title: "Lift Service Error", message: "Please Check Service Connection!");
      },
      (r) {
        renewTimeStamp();
        finalResultUp = true;
        state = state.loaded;
        notifyListeners();
      },
    );

    return finalResultUp;
  }

  Future<bool> liftDown() async {
    state = state.loading;
    notifyListeners();
    bool finalResultDown = false;

    final responseUp = await _service.downLift();
    responseUp.fold(
      (l) {
        finalResultDown = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(
            title: "Lift Service Error", message: "Please Check Service Connection!");
      },
      (r) {
        renewTimeStamp();
        finalResultDown = true;
        state = state.loaded;
        notifyListeners();
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
        ToastHelper.showCoolErrorToast(
            title: "Lift Service Error", message: "Please Check Service Connection!");
      },
      (r) {
        renewTimeStamp();
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
    final response = await _service.emergencyStop();

    bool result = false;
    response.fold(
      (l) {
        isEmergencyActive = false;
        result = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(
            title: "Lift Service Error", message: "Please Check Connection Service!");
      },
      (r) {
        renewTimeStamp();
        isEmergencyActive = false;
        result = true;
        state = state.loaded;
        notifyListeners();
      },
    );
    return result;
  }

  Future<bool> emergencyStart() async {
    state = state.loading;
    notifyListeners();
    final response = await _service.emergencyStart();

    bool result = false;
    response.fold(
      (l) {
        isEmergencyActive = true;
        result = false;
        state = state.failed;
        notifyListeners();
        ToastHelper.showCoolErrorToast(
            title: "Lift Service Error", message: "Please Check Service Connection!");
      },
      (r) {
        renewTimeStamp();
        isEmergencyActive = true;
        result = true;
        state = state.loaded;
        notifyListeners();
      },
    );
    return result;
  }
}
