import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  bool isDark;

  Future<void> _saveValue(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> _getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  void changeThemeMode({required bool newIsDark}) async {
    isDark = newIsDark;

    await _saveValue('isDark', isDark);
    notifyListeners();
  }

  Future<void> fetchData() async {
    bool? val = await _getValue('isDark');
    if (val == null || val == false) {
      isDark = false;
    } else {
      isDark = true;
    }
    notifyListeners();
  }

  void check() async {
    await fetchData();
  }

  ThemeModeProvider({this.isDark = false}) {
    check();
  }
}
