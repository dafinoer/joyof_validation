
import 'package:validation_ektp/models/region.dart';

abstract class DetailImplement {
  Future<List<Region>> getProvinsi(String url);
  Future<List<Region>> getKabupaten(String url);
  Future<List<Region>> getKecamatan(String url);
  Future<List<Region>> getKelurahan(String url);
}