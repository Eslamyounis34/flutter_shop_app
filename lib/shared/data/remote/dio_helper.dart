import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../local/chache_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      required String token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept': '*/*',
      'Authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept': '*/*',
      'Authorization': token,
    };
    return dio!.post(url, data: data);
  }
}
