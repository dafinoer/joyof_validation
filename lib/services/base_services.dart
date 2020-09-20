import 'dart:io';
import 'package:dio/dio.dart';

class BaseService {
  final dio = Dio();

  Future<dynamic> getData(String url,
      {Map<String, dynamic> queryparams}) async {
    try {
      final result = await dio.get(url, queryParameters: queryparams);
      return result.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) {
        throw DioError(type: DioErrorType.RESPONSE, response: e.response, error: e.error);
      } else {
        throw Exception(e);
      }
    }
  }
}
