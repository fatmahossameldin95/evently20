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

  changeLocal() {
    if (local == 'en') {
      local = ('ar');
    } else {
      local = ('en');
    }
    notifyListeners();
  }
}
