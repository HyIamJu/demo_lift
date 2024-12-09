import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kTokenLoginAuth = 'token_login_auth';
const String _kUserData = 'user_data';
const String _kLiftSelected = 'lift_selected';
const String _kLiftSelecteName = 'lift_selected_name';

class SharedPreferencesServices {
  static SharedPreferencesServices? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesServices._();

  // Singleton pattern with asynchronous initialization
  static Future<SharedPreferencesServices> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesServices._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// claer all data saved to cache
  Future<bool> clearAll() async {
    bool? isClear = await _preferences?.clear();
    return isClear ?? false;
  }

  dynamic _getData(String key) {
    try {
      var value = _preferences?.get(key);
      debugPrint('Retrieved $key: $value');
      return value;
    } catch (e) {
      debugPrint('Error retrieving $key: $e');
      return null;
    }
  }

  Future<void> _saveData(String key, dynamic value) async {
    try {
      debugPrint('Saving $key: $value');
      if (value is String) {
        await _preferences?.setString(key, value);
      } else if (value is int) {
        await _preferences?.setInt(key, value);
      } else if (value is double) {
        await _preferences?.setDouble(key, value);
      } else if (value is bool) {
        await _preferences?.setBool(key, value);
      } else if (value is List<String>) {
        await _preferences?.setStringList(key, value);
      } else {
        throw UnsupportedError('Unsupported type');
      }
    } catch (e) {
      debugPrint('Error saving $key: $e');
    }
  }

  // ----------------------------------------------
  // get and save token login
  // ----------------------------------------------
  String get readToken => _getData(_kTokenLoginAuth) ?? "";
  void saveToken(String value) => _saveData(_kTokenLoginAuth, value);

  // ----------------------------------------------
  // get and save usser
  // ----------------------------------------------
  String get readUser => _getData(_kUserData) ?? "";
  void saveUser(String value) => _saveData(_kUserData, value);

  // ----------------------------------------------
  // get and save usser
  // ----------------------------------------------
  String get readSelectedLift => _getData(_kLiftSelected) ?? "";
  String get readSelectedNameLift => _getData(_kLiftSelecteName) ?? "";
  void saveLiftSelected(String value) => _saveData(_kLiftSelected, value);
  void saveNameLiftSelected(String value) => _saveData(_kLiftSelecteName, value);
}
