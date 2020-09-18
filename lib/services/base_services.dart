import 'dart:io';

import 'package:dio/dio.dart';

class BaseService {
  final dio = Dio();

  Future<dynamic> getData(String url) async {
    try {
      final result = await dio.get(url);
      if (result.statusCode != 200) {
        return HttpException(result.statusMessage, uri: result.realUri);
      }
      return result.data;
    } on HttpException catch (e) {
      throw Exception(e);
    }
  }
}
