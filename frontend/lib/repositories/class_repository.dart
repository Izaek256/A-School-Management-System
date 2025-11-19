import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/class_model.dart';

class ClassRepository extends BaseRepository {
  ClassRepository(super.apiService);

  @override
  String get basePath => '/classes';

  Future<List<ClassModel>> getClasses() async {
    return await getList(ClassModel.fromJson);
  }

  Future<ClassModel> getClassById(String id) async {
    return await getById(id, ClassModel.fromJson);
  }

  Future<ClassModel> createClass(Map<String, dynamic> data) async {
    return await create(data, ClassModel.fromJson);
  }

  Future<ClassModel> updateClass(String id, Map<String, dynamic> data) async {
    return await update(id, data, ClassModel.fromJson);
  }
}