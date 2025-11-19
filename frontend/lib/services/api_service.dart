import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/utils/config.dart';
import 'package:frontend/exceptions/api_exception.dart';

class ApiService {
  static String baseUrl = Config.baseUrl;

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _handleDioError(e);
          return handler.next(e);
        },
      ),
    );
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 401:
            throw UnauthorizedException();
          case 403:
            throw ForbiddenException();
          case 404:
            throw NotFoundException();
          case 500:
          case 502:
          case 503:
            throw ServerException();
          default:
            throw ApiException(
              e.response?.statusMessage ?? 'Unknown error',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
        }
      case DioExceptionType.cancel:
        throw ApiException('Request was cancelled');
      case DioExceptionType.unknown:
        throw NetworkException();
      default:
        throw ApiException(e.message ?? 'Unknown error');
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<Response> post(String path, {Object? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<Response> put(String path, {Object? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }
}
