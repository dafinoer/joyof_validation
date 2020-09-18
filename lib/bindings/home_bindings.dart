import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() {
    //   final controller = Get.find<HomeController>();
    //   final controllerTxtKtp = TextEditingController();
    //   controllerTxtKtp
    //       .addListener(() => controller.setKtpText(controllerTxtKtp.text));

    //   return controllerTxtKtp;
    // });
  }
}
