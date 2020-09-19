import 'package:validation_ektp/models/region.dart';
import 'package:validation_ektp/repository/detail_implement.dart';
import 'package:validation_ektp/services/base_services.dart';

class DetailRepository implements DetailImplement {
  BaseService _service;

  DetailRepository(BaseService paramService) {
    this._service = paramService;
  }

  @override
  Future<List<Region>> getKabupaten(String url) async {
    final itemResult = getProvinsi(url);
    return itemResult;
  }

  @override
  Future<List<Region>> getProvinsi(String url) async {
    final itemResult = await _service.getData(url);
    // print(itemResult);
    if (itemResult != null) {
      final tempResult = List.from(itemResult);
      return tempResult.map((e) => Region.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<List<Region>> getKecamatan(String url) {
    final itemResult = getProvinsi(url);
    return itemResult;
  }

  @override
  Future<List<Region>> getKelurahan(String url) async {
    final result = await getProvinsi(url);
    return result;
  }
}
