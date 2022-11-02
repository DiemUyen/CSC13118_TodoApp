import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = "THEMESTATUS";

  setDarkTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(themeStatus, isDark);
  }

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(themeStatus) ?? false;
  }
}