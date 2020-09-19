import 'package:get/route_manager.dart';
import 'package:validation_ektp/bindings/detail_binding.dart';
import 'package:validation_ektp/bindings/home_bindings.dart';
import 'package:validation_ektp/routes/app_routes.dart';
import 'package:validation_ektp/screen/detail/detail_page.dart';
import 'package:validation_ektp/screen/main_page.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: Routes.HOME, page: () => MainPage(), binding: HomeBinding()),
    GetPage(
        name: Routes.DETAILS,
        page: () => DetailPage(),
        binding: DetailBinding()),
  ];
}
