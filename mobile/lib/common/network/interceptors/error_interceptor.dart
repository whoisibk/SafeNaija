import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle specific error codes or map to custom exceptions here
    // For now, we just pass it through
    super.onError(err, handler);
  }
}
