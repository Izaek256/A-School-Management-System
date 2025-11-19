import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/assignment.dart';
import 'package:frontend/repositories/assignment_repository.dart';
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

class AssignmentNotifier extends AsyncNotifier<List<Assignment>> {
  late final AssignmentRepository _repository;

  @override
  Future<List<Assignment>> build() async {
    _repository = ref.read(assignmentRepositoryProvider);
    return await _loadAssignments();
  }

  Future<List<Assignment>> _loadAssignments() async {
    return await _repository.getAssignments();
  }

  Future<Assignment> createAssignment(Map<String, dynamic> data) async {
    try {
      final assignment = await _repository.createAssignment(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAssignments());
      return assignment;
    } catch (e) {
      rethrow;
    }
  }

  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data) async {
    try {
      final assignment = await _repository.updateAssignment(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAssignments());
      return assignment;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAssignment(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAssignments());
    } catch (e) {
      rethrow;
    }
  }
}

final assignmentNotifierProvider = AsyncNotifierProvider<AssignmentNotifier, List<Assignment>>(AssignmentNotifier.new);