import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/teacher.dart';

class TeacherRepository extends BaseRepository {
  TeacherRepository(super.apiService);

  @override
  String get basePath => '/api/teachers/teachers';

  Future<List<Teacher>> getTeachers() async {
    return await getList(Teacher.fromJson);
  }

  Future<Teacher> getTeacherById(String id) async {
    return await getById(id, Teacher.fromJson);
  }

  Future<Teacher> createTeacher(Map<String, dynamic> data) async {
    return await create(data, Teacher.fromJson);
  }

  Future<Teacher> updateTeacher(String id, Map<String, dynamic> data) async {
    return await update(id, data, Teacher.fromJson);
  }
}
