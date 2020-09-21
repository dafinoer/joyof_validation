import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/routes/app_routes.dart';
import 'package:validation_ektp/screen/home/home_page.dart';
import 'package:validation_ektp/utils/themes_custom.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('eKtp'),
          actions: [
            IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  // Get.toNamed(Routes.SETTINGS);
                  Get.changeTheme(
                      Get.isDarkMode ? ThemesCustome.lightCustom(ThemeData.light()) : ThemeData.dark());
                })
          ],
        ),
        body: SafeArea(child: HomePage()));
  }
}
