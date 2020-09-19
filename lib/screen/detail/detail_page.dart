import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:validation_ektp/controllers/detail_controller.dart';
import 'package:validation_ektp/utils/date_format_utils.dart';
import 'package:validation_ektp/utils/strings.dart';

class DetailPage extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.APPBAR_DETAIL),
        ),
        body: Obx(() {
          if (controller.status.value == Status.loading) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                  width: mediaQuery.size.width,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white30,
                    highlightColor: Colors.white60,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }

          if (controller.status.value == Status.notvalid) {
            return Center(
              child: Text('no E-Ktp tidak valid'),
            );
          }

          if (controller.status.value == Status.success) {
            return ListView(
              children: [
                ListTile(
                  title: Text(Strings.NOKTP),
                  subtitle: Text(controller.controllerHome.noKtp.value ?? '0'),
                ),
                ListTile(
                  title: Text(Strings.PROVINSI),
                  subtitle: Text(controller.provinsi.value),
                ),
                ListTile(
                  title: Text(Strings.KABUPATEN),
                  subtitle: Text(controller.kabupaten.value),
                ),
                ListTile(
                  title: Text(Strings.KECAMATAN),
                  subtitle: Text(controller.kecamatan.value),
                ),
                ListTile(
                  title: Text(Strings.BIRTHDATE),
                  subtitle: Text(DateFormatUtils.simpleDateFormat(
                      DateTime.fromMillisecondsSinceEpoch(
                          controller.controllerHome.datetime.value))),
                ),
              ],
            );
          }

          if (controller.status.value == Status.error) {
            return Center(
              child: Text('upps error'),
            );
          }
          return SizedBox();
        }));
  }
}
