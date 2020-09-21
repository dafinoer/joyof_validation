import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/controllers/settings_controller.dart';
import 'package:validation_ektp/repository/settings/setting_repository.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MyPageController>(() => {2:MyPage} Controller(
    //   repository: MyUserRepository(apiClient: MyDataProvider(httpClient: http.Client()))));
    // }
    Get.lazyPut(() => SettingsController(
        repository: SettingRepository(Theme.of(Get.context))));
  }
}
