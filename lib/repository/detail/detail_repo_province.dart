import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:validation_ektp/models/region.dart';
import 'package:validation_ektp/repository/detail/base_detail_repo.dart';
import 'package:validation_ektp/repository/detail/detail_base.dart';
import 'package:validation_ektp/services/base_services.dart';
import 'package:validation_ektp/utils/logger.dart';

class DetailRepoProvince extends BaseRepository implements BaseDetailRepo {
  DetailRepoProvince(BaseService paramService) : super(paramService);

  @override
  String getKtp() => noKtp;

  @override
  Future<String> getRegion(String url) async {
    try {
      final province = await baseService.getData(url);

      if (province != null && province.isNotEmpty) {
        final tempData = List.from(province);
        final regions = tempData.map((e) => Region.fromJson(e)).toList();

        final dataProvince = regions
            .where((element) => element.id.contains(noKtp.substring(0, 2)))
            .toList();

        return dataProvince.isNotEmpty ? dataProvince.first.name : null;
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
