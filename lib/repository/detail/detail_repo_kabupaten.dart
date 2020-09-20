import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:validation_ektp/models/region.dart';
import 'package:validation_ektp/repository/detail/base_detail_repo.dart';
import 'package:validation_ektp/repository/detail/detail_base.dart';
import 'package:validation_ektp/services/base_services.dart';
import 'package:validation_ektp/utils/logger.dart';

class DetailRepoKabupaten extends BaseRepository implements BaseDetailRepo {
  DetailRepoKabupaten(BaseService service) : super(service);

  @override
  Future<String> getRegion(String url) async {
    try {
      final resultKabupaten = await baseService.getData(url);

      if (resultKabupaten != null && resultKabupaten.isNotEmpty) {
        final tempData = List.from(resultKabupaten);
        final regions = tempData.map((e) => Region.fromJson(e)).toList();
        final dataKabupaten = regions
            .where((element) => element.id.contains(noKtp.substring(0, 4)))
            .toList();

        return dataKabupaten.isNotEmpty ? dataKabupaten.first.name : null;
      }
      return null;
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw DioError(error: e.error);
      } else {
        throw Exception(e);
      }
    }
  }

  @override
  String getKtp() {
    return noKtp;
  }
}
