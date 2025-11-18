import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/assignment.dart';
import 'package:frontend/repositories/assignment_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AssignmentRepository(apiService);
});

final assignmentsProvider = FutureProvider<List<Assignment>>((ref) async {
  final repository = ref.watch(assignmentRepositoryProvider);
  return await repository.getAssignments();
});

final assignmentProvider = FutureProvider.family<Assignment, String>((ref, id) async {
  final repository = ref.watch(assignmentRepositoryProvider);
  return await repository.getAssignmentById(id);
});

class AssignmentNotifier extends StateNotifier<AsyncValue<List<Assignment>>> {
  final AssignmentRepository _repository;

  AssignmentNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadAssignments() async {
    state = const AsyncValue.loading();
    try {
      final assignments = await _repository.getAssignments();
      state = AsyncValue.data(assignments);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Assignment> createAssignment(Map<String, dynamic> data) async {
    try {
      final assignment = await _repository.createAssignment(data);
      // Reload the list
      await loadAssignments();
      return assignment;
    } catch (e) {
      rethrow;
    }
  }

  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data) async {
    try {
      final assignment = await _repository.updateAssignment(id, data);
      // Reload the list
      await loadAssignments();
      return assignment;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAssignment(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadAssignments();
    } catch (e) {
      rethrow;
    }
  }
}

final assignmentNotifierProvider = StateNotifierProvider<AssignmentNotifier, AsyncValue<List<Assignment>>>((ref) {
  final repository = ref.watch(assignmentRepositoryProvider);
  return AssignmentNotifier(repository);
});