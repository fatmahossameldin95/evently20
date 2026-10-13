import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String local = ("en");

  changeTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  changeThemeWithMode(ThemeMode mode) {
    if (themeMode != mode) {
      themeMode = mode;
    }
    notifyListeners();
  }

  changeLocal() {
    if (local == 'en') {
      local = ('ar');
    } else {
      local = ('en');
    }
    notifyListeners();
  }

  changeLocalWithCode(String code) {
    if (local != (code)) {
      local = (code);
    }
    notifyListeners();
  }
}
