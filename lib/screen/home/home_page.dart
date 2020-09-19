import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:validation_ektp/controllers/home_controller.dart';
import 'package:validation_ektp/utils/strings.dart';
import 'package:validation_ektp/widgets/card_home_widget.dart';

class HomePage extends GetView<HomeController> {
  final dateNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      maxLength: 16,
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
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      height: 30.0,
                      width: 100.0,
                      child: Obx(() {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          color: Colors.purple[500],
                          onPressed: controller.isActiveButton.value
                              ? controller.onsave
                              : null,
                          child: Text(
                            Strings.SUBMIT,
                            style: theme.textTheme.button,
                          ),
                        );
                      })),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CardHomeWidget(),
                )
              ],
            ),
          )),
        ),
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
