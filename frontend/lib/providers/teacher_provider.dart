import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/teacher.dart';
import 'package:frontend/repositories/teacher_repository.dart';
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

class TeacherNotifier extends AsyncNotifier<List<Teacher>> {
  late final TeacherRepository _repository;

  @override
  Future<List<Teacher>> build() async {
    _repository = ref.read(teacherRepositoryProvider);
    return await _loadTeachers();
  }

  Future<List<Teacher>> _loadTeachers() async {
    return await _repository.getTeachers();
  }

  Future<Teacher> createTeacher(Map<String, dynamic> data) async {
    try {
      final teacher = await _repository.createTeacher(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadTeachers());
      return teacher;
    } catch (e) {
      rethrow;
    }
  }

  Future<Teacher> updateTeacher(String id, Map<String, dynamic> data) async {
    try {
      final teacher = await _repository.updateTeacher(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadTeachers());
      return teacher;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTeacher(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadTeachers());
    } catch (e) {
      rethrow;
    }
  }
}

final teacherNotifierProvider = AsyncNotifierProvider<TeacherNotifier, List<Teacher>>(TeacherNotifier.new);