import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/exam.dart';

class ExamRepository extends BaseRepository {
  ExamRepository(super.apiService);

  @override
  String get basePath => '/api/academics/exams';

  Future<List<Exam>> getExams() async {
    return await getList(Exam.fromJson);
  }

  Future<Exam> getExamById(String id) async {
    return await getById(id, Exam.fromJson);
  }

  Future<Exam> createExam(Map<String, dynamic> data) async {
    return await create(data, Exam.fromJson);
  }

  Future<Exam> updateExam(String id, Map<String, dynamic> data) async {
    return await update(id, data, Exam.fromJson);
  }
}
