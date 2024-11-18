import 'package:dio/dio.dart';

import 'interceptor_dio.dart';

class HelperApi {
  static final client = AppInterceptor();

  static Future<dynamic> httpPost(
      {required Map<String, dynamic> body,
      required String path,
      Map<String, dynamic>? header}) async {
    try {
      var response = await client.dio.post(
        path,
        data: body,
        options: Options(headers: header),
      );

      return response.data;
    } on DioException catch (e) {
      return Future.error(e.error ?? 'เกิดข้อผิดพลาด');
    }
  }

  static Future<dynamic> httpGet({
    required String path,
    Options? options,
  }) async {
    try {
      var response = await client.dio.get(
        path,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      return Future.error(e.error ?? 'เกิดข้อผิดพลาด');
    }
  }

  static Future<dynamic> httpPut(
      {required Map<String, dynamic> body,
      required String path,
      Map<String, dynamic>? header}) async {
    try {
      var response = await client.dio.put(
        path,
        data: body,
        options: Options(headers: header),
      );

      return response.data;
    } on DioException catch (e) {
      return Future.error(e.error ?? 'เกิดข้อผิดพลาด');
    }
  }
}
