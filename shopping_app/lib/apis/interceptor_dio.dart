import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_app/service/app_unity.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor {
  Dio dio = Dio();

  static String baseUrl = "http://localhost:8080";

  // MemberController member = Get.find();

  AppInterceptor() {
    dio.options = BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      headers: {},
      connectTimeout: const Duration(seconds: 20),
      // sendTimeout: const Duration(
      //   seconds: 20,
      // ),
    );
    // log api
    dio.options.followRedirects = false;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions requestOptions,
            RequestInterceptorHandler handler) async {
          handler.next(requestOptions);
        },
        onResponse: (e, handler) {
          if (e.statusCode == 200) {
            handler.next(e);
          } else if (e.statusCode == 401) {
            AppUnity.sharedPreferences.then((value) {});
          }
          // else {
          //   return handler.reject(
          //     DioException(
          //       requestOptions: e.requestOptions,
          //       error: e.data['message'],
          //     ),
          //   );
          // }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          print("${err.requestOptions.path}: ${err.response?.statusMessage}");
          print(err.response?.statusCode);
          if (err.response?.statusCode == 401) {
            AppUnity.sharedPreferences.then((value) {
              value.remove('token');
              String? phone = value.getString('phone');
              // Get.offAllNamed(enterPinLogin, arguments: {'phone': phone});
            });
          } else {
            handler.resolve(err.response!);
          }
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ));
  }

  Dio copyDio(Dio original) {
    final newDio = Dio(BaseOptions(
      baseUrl: original.options.baseUrl,
      connectTimeout: original.options.connectTimeout,
      receiveTimeout: original.options.receiveTimeout,
      headers:
          Map<String, dynamic>.from(original.options.headers), // Copy headers
    ));
    newDio.interceptors
        .addAll(original.interceptors.map((interceptor) => interceptor));
    return newDio;
  }

  static Future<void> refreshToken() async {}
}
