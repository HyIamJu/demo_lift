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
import '../views/dialogs/app_dialog.dart';

class AuthProvider extends ChangeNotifier {
  Failure? failure;
  MyState state = MyState.initial;
  UserModel? user;
  String? token;

  final _service = serviceLocator<AuthService>();
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  intializeAuthProvider() {
    try {
      String userCache = _sharedPref.readUser;
      if (userCache.isNotEmpty) {
        user = UserModel.fromMap(jsonDecode(userCache));
      }
    } catch (e) {
      debugPrint("error load data usser");
    }
  }

  Future<void> loginWithCard(String idCard) async {
    var uuid = _sharedPref.readSelectedLift;
    AppDialog.dialogLoadingCircle();
    if (!state.isLoading) {
      state = state.loading;
      notifyListeners();
    }
    final result = await _service.login(
      cardId: idCard,
      cargoUuid: uuid,
    );

    result.fold(
      (l) {
        failure = l;
        AppDialog.toastError(l.errorMessage, longDuration: true);
        AppDialog.dismissAllDialog();
        state = state.failed;
        notifyListeners();
      },
      (data) {
        // assign ke variable provider
        user = UserModel.fromMap(data['DATA']);
        token = data['TOKEN'];
        // save to cache
        _sharedPref.saveUser((data['DATA'].toString()));
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
