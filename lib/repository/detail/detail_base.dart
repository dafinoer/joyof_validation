import 'package:validation_ektp/services/base_services.dart';

class BaseRepository {
  BaseService baseService;

  String noKtp;

  BaseRepository(BaseService paramService) {
    this.baseService = paramService;
  }
}
