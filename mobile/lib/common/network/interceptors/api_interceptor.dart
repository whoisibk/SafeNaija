import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json';
    }
    options.headers['Accept'] = 'application/json';
    // Add auth token here if available
    super.onRequest(options, handler);
  }
}
