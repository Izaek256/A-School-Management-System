import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/exam.dart';
import 'package:frontend/repositories/exam_repository.dart';
import 'package:frontend/services/api_service.dart';
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

class ExamNotifier extends StateNotifier<AsyncValue<List<Exam>>> {
  final ExamRepository _repository;

  ExamNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadExams() async {
    state = const AsyncValue.loading();
    try {
      final exams = await _repository.getExams();
      state = AsyncValue.data(exams);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Exam> createExam(Map<String, dynamic> data) async {
    try {
      final exam = await _repository.createExam(data);
      // Reload the list
      await loadExams();
      return exam;
    } catch (e) {
      rethrow;
    }
  }

  Future<Exam> updateExam(String id, Map<String, dynamic> data) async {
    try {
      final exam = await _repository.updateExam(id, data);
      // Reload the list
      await loadExams();
      return exam;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExam(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadExams();
    } catch (e) {
      rethrow;
    }
  }
}

final examNotifierProvider = StateNotifierProvider<ExamNotifier, AsyncValue<List<Exam>>>((ref) {
  final repository = ref.watch(examRepositoryProvider);
  return ExamNotifier(repository);
});