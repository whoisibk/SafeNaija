import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/config/environment.dart' as config;
import 'package:mobile/common/network/interceptors/api_interceptor.dart';
import 'package:mobile/common/network/interceptors/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(ApiInterceptor apiInterceptor, ErrorInterceptor errorInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.Environment.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.addAll([
      apiInterceptor,
      errorInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);

    return dio;
  }
}
