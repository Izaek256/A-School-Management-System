import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/teacher.dart';
import 'package:frontend/repositories/teacher_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final teacherRepositoryProvider = Provider<TeacherRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TeacherRepository(apiService);
});

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  final repository = ref.watch(teacherRepositoryProvider);
  return await repository.getTeachers();
});

final teacherProvider = FutureProvider.family<Teacher, String>((ref, id) async {
  final repository = ref.watch(teacherRepositoryProvider);
  return await repository.getTeacherById(id);
});

class TeacherNotifier extends StateNotifier<AsyncValue<List<Teacher>>> {
  final TeacherRepository _repository;

  TeacherNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadTeachers() async {
    state = const AsyncValue.loading();
    try {
      final teachers = await _repository.getTeachers();
      state = AsyncValue.data(teachers);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Teacher> createTeacher(Map<String, dynamic> data) async {
    try {
      final teacher = await _repository.createTeacher(data);
      // Reload the list
      await loadTeachers();
      return teacher;
    } catch (e) {
      rethrow;
    }
  }

  Future<Teacher> updateTeacher(String id, Map<String, dynamic> data) async {
    try {
      final teacher = await _repository.updateTeacher(id, data);
      // Reload the list
      await loadTeachers();
      return teacher;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTeacher(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadTeachers();
    } catch (e) {
      rethrow;
    }
  }
}

final teacherNotifierProvider = StateNotifierProvider<TeacherNotifier, AsyncValue<List<Teacher>>>((ref) {
  final repository = ref.watch(teacherRepositoryProvider);
  return TeacherNotifier(repository);
});