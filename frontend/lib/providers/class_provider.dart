import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/class_model.dart';
import 'package:frontend/repositories/class_repository.dart';
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

class ClassNotifier extends AsyncNotifier<List<ClassModel>> {
  late final ClassRepository _repository;

  @override
  Future<List<ClassModel>> build() async {
    _repository = ref.read(classRepositoryProvider);
    return await _loadClasses();
  }

  Future<List<ClassModel>> _loadClasses() async {
    return await _repository.getClasses();
  }

  Future<ClassModel> createClass(Map<String, dynamic> data) async {
    try {
      final classModel = await _repository.createClass(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadClasses());
      return classModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<ClassModel> updateClass(String id, Map<String, dynamic> data) async {
    try {
      final classModel = await _repository.updateClass(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadClasses());
      return classModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClass(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadClasses());
    } catch (e) {
      rethrow;
    }
  }
}

final classNotifierProvider = AsyncNotifierProvider<ClassNotifier, List<ClassModel>>(ClassNotifier.new);