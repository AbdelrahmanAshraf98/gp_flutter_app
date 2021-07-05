import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://rximage.nlm.nih.gov/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required Map<String, dynamic> query,
  }) async{
    return await dio.get(
      'api/rximage/1/rxnav?',
      queryParameters: query,
    );
  }
}