class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}

class NetworkException extends ApiException {
  NetworkException() : super('No internet connection');
}

class TimeoutException extends ApiException {
  TimeoutException() : super('Request timeout');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized access', statusCode: 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException() : super('Access forbidden', statusCode: 403);
}

class NotFoundException extends ApiException {
  NotFoundException() : super('Resource not found', statusCode: 404);
}

class ServerException extends ApiException {
  ServerException() : super('Server error', statusCode: 500);
}
