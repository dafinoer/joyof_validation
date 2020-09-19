import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:validation_ektp/controllers/detail_contoller.dart';
import 'package:validation_ektp/repository/detail_implement.dart';
import 'package:validation_ektp/repository/detail_repository.dart';
import 'package:validation_ektp/services/base_services.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController(Get.find()));
    Get.lazyPut<BaseService>(() => BaseService());
    Get.lazyPut<DetailRepository>(
        () => DetailRepository(Get.find<BaseService>()));
  }
}
