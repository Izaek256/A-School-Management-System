import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/student.dart';

class StudentRepository extends BaseRepository {
  StudentRepository(ApiService apiService) : super(apiService);

  @override
  String get basePath => '/students';

  Future<List<Student>> getStudents() async {
    return await getList(Student.fromJson);
  }

  Future<Student> getStudentById(String id) async {
    return await getById(id, Student.fromJson);
  }

  Future<Student> createStudent(Map<String, dynamic> data) async {
    return await create(data, Student.fromJson);
  }

  Future<Student> updateStudent(String id, Map<String, dynamic> data) async {
    return await update(id, data, Student.fromJson);
  }
}