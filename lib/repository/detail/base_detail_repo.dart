

import 'package:validation_ektp/models/region.dart';

abstract class BaseDetailRepo  {
  String getKtp();
  Future<String> getRegion(String url);
}