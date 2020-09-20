import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:validation_ektp/models/region.dart';
import 'package:validation_ektp/repository/detail/base_detail_repo.dart';
import 'package:validation_ektp/repository/detail/detail_base.dart';
import 'package:validation_ektp/services/base_services.dart';
import 'package:validation_ektp/utils/logger.dart';

class DetailRepoKelurahan extends BaseRepository implements BaseDetailRepo {
  DetailRepoKelurahan(BaseService paramService) : super(paramService);

  @override
  String getKtp() => noKtp;

  @override
  Future<String> getRegion(String url) async {
    try {
      final resultItem = await baseService.getData(url);

      if (resultItem != null && resultItem.isNotEmpty) {
        final tempData = List.from(resultItem);
        final regions = tempData.map((e) => Region.fromJson(e)).toList();

        final dataKecamatan = regions
            .where((element) => element.id.contains(noKtp.substring(0, 4)))
            .toList();

        return dataKecamatan.isNotEmpty ? dataKecamatan.first.name : null;
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
}
