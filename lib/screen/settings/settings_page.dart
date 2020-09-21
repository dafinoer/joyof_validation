import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/controllers/settings_controller.dart';
import 'package:validation_ektp/screen/settings/dark_mode_widget.dart';
import 'package:validation_ektp/utils/strings.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.SETTING),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [DarkModeWidget()],
        ),
      ),
    );
  }
}
