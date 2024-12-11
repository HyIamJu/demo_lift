import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_route_const.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/locator.dart';
import '../services/shared_pref_services.dart';
import '../shared/error/failure.dart';
import '../shared/finite_state.dart';
import '../shared/navigator_keys.dart';
import '../shared/utils/helper_toast.dart';
import '../views/dialogs/app_dialog.dart';

class AuthProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  UserModel? user;
  String? token;

  final _service = serviceLocator<AuthService>();
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  void intializeAuthProvider() {
    try {
      String userCache = _sharedPref.readUser;
      if (userCache.isNotEmpty) {
        var dataMap = jsonDecode(userCache);
        user = UserModel.fromMap(dataMap);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("error load data usser");
    }
  }

  void logoutAndClearAuth() {
    _sharedPref.clearDataAuth();
    user = null;
    token = null;
    notifyListeners();
  }

  Future<void> loginWithNavigation(String idCard) async {
    String uuid = _sharedPref.readSelectedLift;

    if (uuid.isEmpty) {
      ToastHelper.showCoolErrorToast(
          title: "Lift not selected", message: "Please set lift first!");
    } else {
      AppDialog.dialogLoadingCircle();
      if (!state.isLoading) {
        state = state.loading;
        notifyListeners();
      }
      final result = await _service.login(
        cardId: idCard,
        cargoUuid: uuid,
      );
      AppDialog.dismissAllDialog();

      result.fold(
        (l) {
          failure = l;
          AppDialog.dismissAllDialog();
          AppDialog.toastError(l.errorMessage, longDuration: true);
          state = state.failed;
          notifyListeners();
        },
        (data) {
          // assign ke variable provider
          user = UserModel.fromMap(data['DATA']);
          token = data['TOKEN'];
          // save to cache
          _sharedPref.saveUser(jsonEncode((data['DATA'])));
          _sharedPref.saveToken((data['TOKEN'].toString()));
          AppDialog.dismissAllDialog();
          //change state
          state = state.loaded;
          notifyListeners();

          BuildContext? context = navigatorKey.currentState?.context;
          if (context != null) {
            context.go(AppRouteConst.home); // push ke halaman home
          }
        },
      );
    }
  }

  Future<bool> loginWithoutNavigation(String idCard) async {
    String uuid = _sharedPref.readSelectedLift;
    bool isSuccess = false;
    if (uuid.isEmpty) {
      ToastHelper.showCoolErrorToast(
          title: "Lift not selected", message: "Please set lift first!");
    } else {
      AppDialog.dialogLoadingCircle();
      if (!state.isLoading) {
        state = state.loading;
        notifyListeners();
      }
      final result = await _service.login(
        cardId: idCard,
        cargoUuid: uuid,
      );
      AppDialog.dismissAllDialog();

      result.fold(
        (l) {
          isSuccess = false;
          failure = l;
          AppDialog.dismissAllDialog();
          AppDialog.toastError(l.errorMessage, longDuration: true);
          state = state.failed;
          notifyListeners();
        },
        (data) {
          isSuccess = true;
          // assign ke variable provider
          user = UserModel.fromMap(data['DATA']);
          token = data['TOKEN'];
          // save to cache
          _sharedPref.saveUser(jsonEncode((data['DATA'])));
          _sharedPref.saveToken((data['TOKEN'].toString()));
          AppDialog.dismissAllDialog();
          //change state
          state = state.loaded;
          notifyListeners();
        },
      );
    }
    return isSuccess;
  }
}
