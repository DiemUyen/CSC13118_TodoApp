import 'package:flutter/material.dart';
import 'package:todo_app/utils/preferences.dart';

class ThemeProvider extends ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool isDark) {
    _darkTheme = isDark;
    darkThemePreference.setDarkTheme(isDark);
    notifyListeners();
  }
}