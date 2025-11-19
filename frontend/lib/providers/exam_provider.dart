import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/exam.dart';
import 'package:frontend/repositories/exam_repository.dart';
import 'package:frontend/providers/api_service_provider.dart';

final examRepositoryProvider = Provider<ExamRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ExamRepository(apiService);
});

final examsProvider = FutureProvider<List<Exam>>((ref) async {
  final repository = ref.watch(examRepositoryProvider);
  return await repository.getExams();
});

final examProvider = FutureProvider.family<Exam, String>((ref, id) async {
  final repository = ref.watch(examRepositoryProvider);
  return await repository.getExamById(id);
});

class ExamNotifier extends AsyncNotifier<List<Exam>> {
  late final ExamRepository _repository;

  @override
  Future<List<Exam>> build() async {
    _repository = ref.read(examRepositoryProvider);
    return await _loadExams();
  }

  Future<List<Exam>> _loadExams() async {
    return await _repository.getExams();
  }

  Future<Exam> createExam(Map<String, dynamic> data) async {
    try {
      final exam = await _repository.createExam(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadExams());
      return exam;
    } catch (e) {
      rethrow;
    }
  }

  Future<Exam> updateExam(String id, Map<String, dynamic> data) async {
    try {
      final exam = await _repository.updateExam(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadExams());
      return exam;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExam(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadExams());
    } catch (e) {
      rethrow;
    }
  }
}

final examNotifierProvider = AsyncNotifierProvider<ExamNotifier, List<Exam>>(ExamNotifier.new);