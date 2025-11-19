import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/repositories/student_repository.dart';
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

class StudentNotifier extends AsyncNotifier<List<Student>> {
  late final StudentRepository _repository;

  @override
  Future<List<Student>> build() async {
    _repository = ref.read(studentRepositoryProvider);
    return await _loadStudents();
  }

  Future<List<Student>> _loadStudents() async {
    return await _repository.getStudents();
  }

  Future<Student> createStudent(Map<String, dynamic> data) async {
    try {
      final student = await _repository.createStudent(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadStudents());
      return student;
    } catch (e) {
      rethrow;
    }
  }

  Future<Student> updateStudent(String id, Map<String, dynamic> data) async {
    try {
      final student = await _repository.updateStudent(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadStudents());
      return student;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadStudents());
    } catch (e) {
      rethrow;
    }
  }
}

final studentNotifierProvider = AsyncNotifierProvider<StudentNotifier, List<Student>>(StudentNotifier.new);