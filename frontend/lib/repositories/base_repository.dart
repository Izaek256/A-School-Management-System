import 'package:dio/dio.dart';
import 'package:frontend/services/api_service.dart';

abstract class BaseRepository {
  final ApiService apiService;

  BaseRepository(this.apiService);

  String get basePath;

  Future<List<T>> getList<T>(T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await apiService.get(basePath);
      final List<dynamic> data = response.data as List;
      return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<T> getById<T>(String id, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await apiService.get('$basePath/$id/');
      return fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<T> create<T>(Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await apiService.post(basePath, data: data);
      return fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<T> update<T>(String id, Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await apiService.put('$basePath/$id/', data: data);
      return fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await apiService.delete('$basePath/$id/');
    } on DioException catch (e) {
      rethrow;
    }
  }
}