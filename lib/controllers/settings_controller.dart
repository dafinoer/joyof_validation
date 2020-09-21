import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:validation_ektp/repository/settings/dark_mode_state.dart';
import 'package:validation_ektp/repository/settings/setting_repository.dart';

class SettingsController extends GetxController {
  final SettingRepository repository;

  SettingsController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  final _darkMode = Rx<DarkModeState>();
  set setDark(bool darkmode) => this._darkMode.value.isDarkMode = darkmode;
  get darkMode => this._darkMode.value;
}
