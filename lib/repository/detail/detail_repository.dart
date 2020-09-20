import 'package:validation_ektp/repository/detail/detail_base.dart';
import 'package:validation_ektp/repository/detail/detail_repo_kabupaten.dart';
import 'package:validation_ektp/repository/detail/detail_repo_kecamatan.dart';
import 'package:validation_ektp/repository/detail/detail_repo_kelurahan.dart';
import 'package:validation_ektp/repository/detail/detail_repo_province.dart';
import 'package:validation_ektp/services/base_services.dart';

class DetailRepository {
  DetailRepoKabupaten kabupaten;
  DetailRepoKecamatan kecamatan;
  DetailRepoProvince province;
  DetailRepoKelurahan kelurahan;

  DetailRepository(BaseService service) {
    this.kabupaten = DetailRepoKabupaten(service);
    this.province = DetailRepoProvince(service);
    this.kecamatan = DetailRepoKecamatan(service);
    this.kelurahan = DetailRepoKelurahan(service);
  }

  void setKtp(String ktp) {
    kabupaten.noKtp = ktp;
    kecamatan.noKtp = ktp;
    province.noKtp = ktp;
    kelurahan.noKtp = ktp;
  }
}
