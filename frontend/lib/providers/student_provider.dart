import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/repositories/student_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return StudentRepository(apiService);
});

final studentsProvider = FutureProvider<List<Student>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getStudents();
});

final studentProvider = FutureProvider.family<Student, String>((ref, id) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getStudentById(id);
});

class StudentNotifier extends StateNotifier<AsyncValue<List<Student>>> {
  final StudentRepository _repository;

  StudentNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadStudents() async {
    state = const AsyncValue.loading();
    try {
      final students = await _repository.getStudents();
      state = AsyncValue.data(students);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Student> createStudent(Map<String, dynamic> data) async {
    try {
      final student = await _repository.createStudent(data);
      // Reload the list
      await loadStudents();
      return student;
    } catch (e) {
      rethrow;
    }
  }

  Future<Student> updateStudent(String id, Map<String, dynamic> data) async {
    try {
      final student = await _repository.updateStudent(id, data);
      // Reload the list
      await loadStudents();
      return student;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadStudents();
    } catch (e) {
      rethrow;
    }
  }
}

final studentNotifierProvider = StateNotifierProvider<StudentNotifier, AsyncValue<List<Student>>>((ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return StudentNotifier(repository);
});