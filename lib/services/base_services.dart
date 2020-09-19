import 'dart:io';

import 'package:dio/dio.dart';
import 'package:validation_ektp/utils/logger.dart';

class BaseService {
  final dio = Dio();

  Future<dynamic> getData(String url, {Map<String, dynamic> queryparams}) async {
    try {
      final result = await dio.get(url, queryParameters: queryparams);
      // if (result.statusCode != 200) {
      //   return HttpException(result.statusMessage, uri: result.realUri);
      // }
      return result.data;
    } on DioError catch (e) {
      if(e.response.statusCode == 404){
        logger.e(e);
      } else {
        logger.d(e.message);
        logger.d(e.request);
      }
      // throw Exception(e);
    }
  }
}
