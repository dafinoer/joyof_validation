import 'dart:collection';

import 'package:get/get.dart';
import 'package:validation_ektp/controllers/home_controller.dart';
import 'package:validation_ektp/repository/detail_repository.dart';
import 'package:validation_ektp/utils/date_format_utils.dart';
import 'package:validation_ektp/utils/logger.dart';
import 'package:validation_ektp/utils/strings.dart';
import 'package:validation_ektp/utils/urls_endpoint.dart';

enum Status { loading, success, error, notvalid }

class DetailController extends GetxController {
  DetailRepository _detailRepository;

  DetailController(this._detailRepository);

  var status = Status.loading.obs;

  final controllerHome = Get.find<HomeController>();

  var provinsi = Rx<String>();

  var kabupaten = Rx<String>();

  var kecamatan = Rx<String>();

  var kelurahan = Rx<String>();

  var birthDate = Rx<DateTime>();

  @override
  void onInit() {
    checkValidationEktp();
    super.onInit();
  }

  Future<void> checkValidationEktp() async {
    final noKtp = controllerHome.noKtp.value;

    try {
      final provinceName = await fetchProvinsi(noKtp);
      final kabupatenName = await fetchKabupaten(noKtp);
      final kecamatanName = await fetchKecamatan(noKtp);
      final kelurahanName = await fetchKelurahan(noKtp);

      if (provinceName != null &&
          kabupatenName != null &&
          kecamatanName != null &&
          kelurahanName != null &&
          checkingBirthDateTxt(noKtp)) {
        provinsi.value = provinceName;
        kabupaten.value = kabupatenName;
        kecamatan.value = kecamatanName;
        kelurahan.value = kelurahanName;

        status(Status.success);
      } else {
        status(Status.notvalid);
      }
    } catch (e) {
      status(Status.error);
      logger.e(e);
    }
  }

  bool checkingBirthDateTxt(String noKtp) {
    final birthDate = DateTime.fromMillisecondsSinceEpoch(controllerHome.datetime.value);
    final formatDate = DateFormatUtils.formatDayAndMonth(birthDate).replaceAll('/', '');
    // final ktpBirthdate = int.parse(noKtp.substring(6, 10)).toString();
    var calendarDay = int.parse(noKtp.substring(6, 8));
    final calendarMonth = noKtp.substring(8, 10);

    if(calendarDay > 41){
      calendarDay -= 40;
    }
    

    return formatDate.contains('$calendarDay$calendarMonth');
  }

  bool checkBirthDateFromKtp(String noKtp) {
    var isDateTrue = false;
    final dateNumber = noKtp.substring(6, 12);

    for (var i = 0; i < dateNumber.length; i++) {
      if (i % 2 == 0 && i < 2) {
        final dateCode = int.parse(dateNumber.substring(i, i + 2));
        final totalDay = dateCode > 40 ? dateCode - 40 : dateCode;
        if (totalDay < 1 || totalDay >= 31) {
          isDateTrue = false;
          break;
        } else {
          isDateTrue = true;
        }
      } else if (i % 2 == 0 && i < 4) {
        final dateCode = int.parse(dateNumber.substring(i, i + 2));
        if (dateCode < 1 || dateCode > 12) {
          isDateTrue = false;
          break;
        } else {
          isDateTrue = true;
        }
      }
    }

    return isDateTrue;
  }

  String replaceEndpointId(String endpoint, int from, int to) {
    final ktpNo = controllerHome.noKtp.value;
    final url = endpoint.replaceAll('{id}', ktpNo.substring(from, to));
    return url;
  }

  Future<String> fetchProvinsi(String noktp) async {
    try {
      final province =
          await _detailRepository.getProvinsi(UrlsEndpoint.URL_PROVINCE);

      if (province != null) {
        final dataProvince = province
            .where((element) => element.id.contains(noktp.substring(0, 2)))
            .toList();

        return dataProvince.isNotEmpty ? dataProvince.first.name : null;
      }
      return null;
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  Future<String> fetchKabupaten(String noKtp) async {
    try {
      final resultKabupaten = await _detailRepository
          .getKabupaten(replaceEndpointId(UrlsEndpoint.URL_KABUPATEN, 0, 2));

      if (resultKabupaten != null && resultKabupaten.isNotEmpty) {
        final dataKabupaten = resultKabupaten
            .where((element) => element.id.contains(noKtp.substring(0, 4)))
            .toList();

        return dataKabupaten.isNotEmpty ? dataKabupaten.first.name : null;
      }
      return null;
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  Future<String> fetchKecamatan(String noKtp) async {
    try {
      print(replaceEndpointId(UrlsEndpoint.URL_KECAMATAN, 0, 4));

      final resultItem = await _detailRepository
          .getKecamatan(replaceEndpointId(UrlsEndpoint.URL_KECAMATAN, 0, 4));

      if (resultItem != null && resultItem.isNotEmpty) {
        final dataKecamatan = resultItem
            .where((element) => element.id.contains(noKtp.substring(0, 4)))
            .toList();

        return dataKecamatan.isNotEmpty ? dataKecamatan.first.name : null;
      }
      return null;
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  Future<String> fetchKelurahan(String noKtp) async {
    try {
      final resultItem = await _detailRepository
          .getKelurahan(replaceEndpointId(UrlsEndpoint.URL_KELURAHAN, 0, 6));

      if (resultItem != null && resultItem.isNotEmpty) {
        final dataKelurahan = resultItem
            .where((element) => element.id.contains(noKtp.substring(0, 6)))
            .toList();

        return dataKelurahan.isNotEmpty ? dataKelurahan.first.name : null;
      }
      return null;
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }
}
