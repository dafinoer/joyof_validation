import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';
import 'package:validation_ektp/controllers/detail_controller.dart';
import 'package:validation_ektp/controllers/home_controller.dart';
import 'package:validation_ektp/repository/detail/detail_repository.dart';
import 'package:validation_ektp/services/base_services.dart';

class DetailMock extends Mock implements Dio {}

main() {
  final ektpFemale = '3174096112900001';
  final ektpMale = '3203012503770011';

  group('Detail', () {


    BindingsBuilder binding;

    setUp(() {
      initializeDateFormatting();
      binding = BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
        Get.lazyPut<DetailController>(() => DetailController(Get.find()));
        Get.lazyPut<BaseService>(() => BaseService());
        Get.lazyPut<DetailRepository>(
            () => DetailRepository(Get.find<BaseService>()));
        
      });
    });

    test('Test binding', () {
      expect(Get.isPrepared<DetailController>(), false);
      expect(Get.isPrepared<BaseService>(), false);
      expect(Get.isPrepared<DetailRepository>(), false);

      binding.builder();

      expect(Get.isPrepared<DetailController>(), true);
      expect(Get.isPrepared<BaseService>(), true);
      expect(Get.isPrepared<DetailRepository>(), true);
    });

    test('date controller', () {
      binding.builder();

      final controller = Get.find<DetailController>();

      Get.find<HomeController>();

      expect(controller.initialized, true);

      final dateTimeMale = DateTime.parse('1977-03-25').millisecondsSinceEpoch;
      expect(controller.checkingBirthDateTxt(ektpMale, dateTimeMale), isTrue);

      // 611290
      final birthDateFemale =
          DateTime.parse('1990-12-21').millisecondsSinceEpoch;
      expect(
          controller.checkingBirthDateTxt(ektpFemale, birthDateFemale), isTrue);

      final dateMaleFalse = DateTime.parse('1977-03-23').millisecondsSinceEpoch;
      expect(controller.checkingBirthDateTxt(ektpMale, dateMaleFalse), isFalse);

      // 611290
      final dateFemaleFalse =
          DateTime.parse('1990-12-25').millisecondsSinceEpoch;
      expect(controller.checkingBirthDateTxt(ektpFemale, dateFemaleFalse),
          isFalse);

      expect(controller.checkBirthDateFromKtp(ektpMale),
          predicate((_) => true, 'istrue'));
      expect(controller.checkBirthDateFromKtp('928394823942'), isFalse);
    });

    test('fetch province', () async {
      binding.builder();

      final controller = Get.find<DetailController>();

      Get.find<HomeController>();

      expect(controller.initialized, isTrue);

      expect(await controller.fetchProvinsi(ektpMale), isA<String>());
      expect(await controller.fetchProvinsi(ektpFemale), isA<String>());
      expect(await controller.fetchProvinsi('sdfkhasdfakj'), isNull);
    });

    test('fetch kabupaten', () {
      expect(Get.isPrepared<DetailMock>(), isFalse);

      binding.builder();

      expect(Get.isPrepared<DetailMock>(), isTrue);
      // final mockController = DetailMock(Get.find<DetailRepository>());
      
      // final dateTimeMale = DateTime.parse('1977-03-25').millisecondsSinceEpoch;
      // expect(mockController.checkingBirthDateTxt(ektpMale, dateTimeMale), isTrue);
    });


    test('fetch kecamatan', () {
      
    });


    test('fetch kelurahan', () {
      
    });
  });
}
