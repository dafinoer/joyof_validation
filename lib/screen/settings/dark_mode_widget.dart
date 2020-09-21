import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/utils/strings.dart';
import 'package:validation_ektp/utils/themes_custom.dart';

class DarkModeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(Strings.DARK_MODE),
        secondary: Icon(Icons.lightbulb_outline),
        value: Get.isDarkMode,
        onChanged: (value) {
          Get.changeTheme(Get.isDarkMode
              ? ThemesCustome.lightCustom(ThemeData.light())
              : ThemeData.dark());
        },
      );
    }
}
