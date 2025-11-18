import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/assignment.dart';

class AssignmentRepository extends BaseRepository {
  AssignmentRepository(ApiService apiService) : super(apiService);

  @override
  String get basePath => '/assignments';

  Future<List<Assignment>> getAssignments() async {
    return await getList(Assignment.fromJson);
  }

  Future<Assignment> getAssignmentById(String id) async {
    return await getById(id, Assignment.fromJson);
  }

  Future<Assignment> createAssignment(Map<String, dynamic> data) async {
    return await create(data, Assignment.fromJson);
  }

  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data) async {
    return await update(id, data, Assignment.fromJson);
  }
}