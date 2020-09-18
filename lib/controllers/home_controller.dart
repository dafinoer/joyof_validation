import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:validation_ektp/models/user.dart';
import 'package:validation_ektp/screen/detail/detail_page.dart';
import 'package:validation_ektp/utils/date_format_utils.dart';
import 'package:validation_ektp/utils/logger.dart';

class HomeController extends GetxController {
  TextEditingController editingControllerDate;

  var users = User().obs;

  var noKtp = ''.obs;

  var name = ''.obs;

  var datetime = 0.obs;

  var isActiveButton = false.obs;

  @override
  void onInit() {
    editingControllerDate = TextEditingController();
    super.onInit();
  }

  void setDate(DateTime time) {
    datetime.value = time.millisecondsSinceEpoch;
    editingControllerDate.text = DateFormatUtils.simpleDateFormat(
        DateTime.fromMillisecondsSinceEpoch(datetime.value));
    isActive();
  }

  void setNoKtp(String text) {
    noKtp.value = text;
    isActive();
  }

  void setKtpText(String ktp) {
    users.update((val) {
      val.noKtp = ktp;
    });
  }

  void setName(String text) {
    name.value = text;
    isActive();
  }

  void isActive() {
    isActiveButton.value = noKtp.value.isNotEmpty &&
        noKtp.value.length >= 16 &&
        name.value.isNotEmpty &&
        datetime.value != 0;
  }

  void onsave() {
    Get.to(DetailPage());
  }
}
