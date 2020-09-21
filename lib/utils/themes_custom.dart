import 'package:flutter/material.dart';

class ThemesCustome {
  static ThemeData lightCustom(ThemeData light) {
    // return ThemeData.dark().copyWith(
    //   buttonColor: Colors.purple[500],
    // );
    return light.copyWith(primaryColor: Colors.purple[800]);
  }

  static ThemeData darkCustom() {
    return ThemeData.light().copyWith(primaryColor: Colors.purple);
  }
}
