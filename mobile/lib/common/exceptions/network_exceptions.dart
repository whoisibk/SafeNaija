class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() => 'NetworkException: $message (Status Code: $statusCode)';
}

class ServerException extends NetworkException {
  ServerException(String message, {int? statusCode})
    : super(message, statusCode: statusCode);
}

class CacheException extends NetworkException {
  CacheException(String message) : super(message);
}

class ParseException extends NetworkException {
  ParseException(String message) : super(message);
}
