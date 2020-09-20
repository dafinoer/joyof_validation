
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:validation_ektp/controllers/home_controller.dart';
import 'package:validation_ektp/repository/detail/detail_repository.dart';
import 'package:validation_ektp/utils/date_format_utils.dart';
import 'package:validation_ektp/utils/logger.dart';
import 'package:validation_ektp/utils/urls_endpoint.dart';

enum Status { loading, success, error, notvalid }

class DetailController extends GetxController {
  DetailRepository _detailRepository;

  DetailController(this._detailRepository);

  final controllerHome = Get.find<HomeController>();

  var status = Status.loading.obs;

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
    _detailRepository.setKtp(noKtp);

    try {
      final urlProvince = rewriteUrlEndpoint(UrlsEndpoint.URL_PROVINCE);
      final urlKabupaten =
          rewriteUrlEndpoint(UrlsEndpoint.URL_KABUPATEN, from: 0, to: 2);
      final urlKecamatan =
          rewriteUrlEndpoint(UrlsEndpoint.URL_KECAMATAN, from: 0, to: 4);
      final urlKelurahan =
          rewriteUrlEndpoint(UrlsEndpoint.URL_KELURAHAN, from: 0, to: 6);

      final provinceName =
          await _detailRepository.province.getRegion(urlProvince);
      final kabupatenName =
          await _detailRepository.kabupaten.getRegion(urlKabupaten);
      final kecamatanName =
          await _detailRepository.kecamatan.getRegion(urlKecamatan);
      final kelurahanName =
          await _detailRepository.kelurahan.getRegion(urlKelurahan);

      if (provinceName != null &&
          kabupatenName != null &&
          kecamatanName != null &&
          kelurahanName != null &&
          checkingBirthDateTxt(noKtp, controllerHome.datetime.value)) {
        provinsi.value = provinceName;
        kabupaten.value = kabupatenName;
        kecamatan.value = kecamatanName;
        kelurahan.value = kelurahanName;

        status(Status.success);
      } else {
        status(Status.notvalid);
      }
    } catch (e) {
      logger.e(e);
      if(e is DioError){
        status(Status.notvalid);
      } else {
        status(Status.error);
      }
    }
  }

  bool checkingBirthDateTxt(String noKtp, int time) {
    final birthDate = DateTime.fromMillisecondsSinceEpoch(time);
    final formatDate = DateFormatUtils.formatDayAndMonth(birthDate).replaceAll('/', '');
    var calendarDay = int.parse(noKtp.substring(6, 8));
    final calendarMonth = int.parse(noKtp.substring(8, 10));

    if (calendarDay > 41) calendarDay -= 40;

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

  String rewriteUrlEndpoint(String endpoint, {int from, int to}) {
    final ktpNo = controllerHome.noKtp.value;
    final url = from == null && to == null
        ? endpoint
        : endpoint.replaceAll('{id}', ktpNo.substring(from, to));
    return url;
  }
}
