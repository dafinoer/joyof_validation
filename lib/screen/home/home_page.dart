import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:validation_ektp/controllers/home_controller.dart';
import 'package:validation_ektp/utils/strings.dart';

class HomePage extends GetView<HomeController> {
  final dateNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return TextField(
                      onChanged: (value) => controller.setNoKtp(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: Strings.INPUT_EKTP,
                        errorText: _validationText(controller),
                      ));
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextField(
                    onChanged: (value) => controller.setName(value),
                    decoration: InputDecoration(
                        hintText: Strings.INPUT_NAME,
                        border: OutlineInputBorder()),
                  ),
                ),
                TextField(
                  controller: controller.editingControllerDate,
                  decoration: InputDecoration(
                      hintText: Strings.INPUT_BIRTHDATE,
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today)),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final date = await showDatePicker(
                        context: context,
                        locale: Locale('id', 'ID'),
                        initialDate: dateNow,
                        firstDate: DateTime(1985, 1),
                        lastDate: dateNow);

                    if (date != null) {
                      controller.setDate(date);
                    }
                  },
                ),
              ],
            ),
          )),
        ),
        Builder(builder: (newcontext) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() {
                  return RaisedButton(
                    onPressed: controller.isActiveButton.value
                        ? controller.onsave
                        : null,

                    // () {
                    //   if (controller.noKtp.value.isEmpty ||
                    //       controller.datetime.value == 0 ||
                    //       controller.name.value.isEmpty) {
                    //     Scaffold.of(newcontext)
                    //         .showSnackBar(SnackBar(content: Text('yey')));
                    //   }
                    // },

                    child: Text(Strings.SUBMIT),
                  );
                })),
          );
        })
      ],
    );
  }

  String _validationText(HomeController controller) {
    if (controller.noKtp.value.isNotEmpty &&
        controller.noKtp.value.length < 16) {
      return 'error';
    }
    return null;
  }
}
