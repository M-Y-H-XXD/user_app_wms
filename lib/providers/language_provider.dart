import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String language;

  Future<void> _saveValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> _getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> fetchData() async {
    String? val = await _getValue('language');
    if (val == null || val == 'en') {
      language = 'en';
    } else {
      language = 'ar';
    }
    notifyListeners();
  }

  void check() async {
    await fetchData();
  }

  void changeLanguage({required String newLanguage}) async {
    language = newLanguage;

    await _saveValue('language', language);
    notifyListeners();
  }

  LanguageProvider({this.language = 'en'}) {
    check();
  }
}
