import 'package:flutter/material.dart';
import 'package:todo_app/utils/color_schemes.dart';

class AppTheme {

  static ThemeData themeData(bool isDarkTheme, BuildContext context, ColorScheme? light, ColorScheme? dark) {
    if (isDarkTheme) {
      /*return ThemeData.dark().copyWith(
        useMaterial3: true,
        //colorScheme: darkColorScheme,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange, brightness: Brightness.dark)
      );*/
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        //colorSchemeSeed: Colors.orange,
        //primarySwatch: Colors.orange
        colorScheme: dark ?? ColorScheme.fromSwatch(primarySwatch: Colors.blue, brightness: Brightness.dark)
      );
    }
    /*return ThemeData.light().copyWith(
      useMaterial3: true,
      //colorScheme: lightColorScheme,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
    );*/
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      //colorSchemeSeed: Colors.orange,
      //primarySwatch: Colors.orange
      colorScheme: dark ?? ColorScheme.fromSwatch(primarySwatch: Colors.blue)
    );
  }
}