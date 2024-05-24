import 'package:dio/dio.dart';

import '../../AppUrl/app_url.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Globals.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Globals.baseUrl,
      receiveTimeout: const Duration(seconds: 5), // 15 seconds
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ));
    return dio;
  }
}


