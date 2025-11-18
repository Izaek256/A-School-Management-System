import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/class_model.dart';
import 'package:frontend/repositories/class_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final classRepositoryProvider = Provider<ClassRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ClassRepository(apiService);
});

final classesProvider = FutureProvider<List<ClassModel>>((ref) async {
  final repository = ref.watch(classRepositoryProvider);
  return await repository.getClasses();
});

final classProvider = FutureProvider.family<ClassModel, String>((ref, id) async {
  final repository = ref.watch(classRepositoryProvider);
  return await repository.getClassById(id);
});

class ClassNotifier extends StateNotifier<AsyncValue<List<ClassModel>>> {
  final ClassRepository _repository;

  ClassNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadClasses() async {
    state = const AsyncValue.loading();
    try {
      final classes = await _repository.getClasses();
      state = AsyncValue.data(classes);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<ClassModel> createClass(Map<String, dynamic> data) async {
    try {
      final classModel = await _repository.createClass(data);
      // Reload the list
      await loadClasses();
      return classModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<ClassModel> updateClass(String id, Map<String, dynamic> data) async {
    try {
      final classModel = await _repository.updateClass(id, data);
      // Reload the list
      await loadClasses();
      return classModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClass(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadClasses();
    } catch (e) {
      rethrow;
    }
  }
}

final classNotifierProvider = StateNotifierProvider<ClassNotifier, AsyncValue<List<ClassModel>>>((ref) {
  final repository = ref.watch(classRepositoryProvider);
  return ClassNotifier(repository);
});