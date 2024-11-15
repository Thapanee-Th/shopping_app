import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_app/service/app_unity.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor {
  Dio dio = Dio();
  Dio dioV2 = Dio();
  //  env = String.fromEnvironment("FLAVOR", defaultValue: "staging");
  static String baseUrl = "https://k3s-staging-app.oishifood.com";
  static String baseUrlV2 = "https://stg-app.oishifood.com";

  // String tokenGuestModeDev =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cyI6MCwiaWQiOiIzIiwidHlwZSI6MSwicGVybWlzc2lvbl9pZCI6MSwiZXhwIjoxNzMxNDI1MzI3LCJpYXQiOjE3MzEzMzg5Mjd9.X7K4JB31c0DYd2F8Wk_80NemAWlnsViGsRwGI-F8fek";
  String tokenGuestModeDev =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cyI6MCwiaWQiOiIzIiwidHlwZSI6MSwicGVybWlzc2lvbl9pZCI6MSwiaWF0IjoxNzMxNjgyODI1fQ.Zvv2_pimzMllU5R--hMDSMym8DwrbZaQCPhd-EJodfo";
  String cardNoDev = "8900190000000801";

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
          await requestOptions.headers.putIfAbsent(
              'Accept-Language', () => Get.context!.locale.languageCode);

          var sharedPreferences = await AppUnity.sharedPreferences;
          String? token = sharedPreferences.getString('token');

          if (token != null) {
            await requestOptions.headers
                .putIfAbsent('Authorization', () => "Bearer $token");
            // await requestOptions.headers
            //     .putIfAbsent('card-no', () => member.memberCard.value.cardNo);
          } else {
            await requestOptions.headers.putIfAbsent(
                'Authorization', () => "Bearer $tokenGuestModeDev");
            await requestOptions.headers
                .putIfAbsent('card-no', () => cardNoDev);
          }

          handler.next(requestOptions);
        },
        onResponse: (e, handler) {
          if (e.statusCode == 200 && e.data['code'] == 200) {
            handler.next(e);
          } else if (e.statusCode == 401 || e.data['code'] == 401) {
            AppUnity.sharedPreferences.then((value) {
              value.remove('token');
              String? phone = value.getString('phone');
              // Get.offAllNamed(enterPinLogin, arguments: {'phone': phone});
            });
          } else {
            return handler.reject(
              DioException(
                requestOptions: e.requestOptions,
                error: e.data['message'],
              ),
            );
          }
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

    //V2
    dioV2 = copyDio(dio); // copy dio to dioV2
    dioV2.options.baseUrl = baseUrlV2;
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
