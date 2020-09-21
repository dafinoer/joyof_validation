import 'package:flutter/material.dart';

class DarkModeState {
  bool isDarkMode;

  ThemeData themeDarkMode;

  DarkModeState(ThemeData themeData) : assert(themeData != null) {
    this.themeDarkMode = themeData;
  }

  ThemeData darkModeCustom() {
    return ThemeData.dark().copyWith(
      buttonColor: Colors.purple[500],
    );
  }

  ThemeData lightModeCustome() {
    return ThemeData.light().copyWith(primaryColor: Colors.purple);
  }
}
