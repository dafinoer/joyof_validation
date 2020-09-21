import 'package:flutter/material.dart';
import 'package:validation_ektp/repository/settings/dark_mode_state.dart';

class SettingRepository {
  DarkModeState darkState;

  SettingRepository(ThemeData theme) {
    darkState = DarkModeState(theme);
  }
}
