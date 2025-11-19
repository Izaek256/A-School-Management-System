import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/notification.dart';

class NotificationRepository extends BaseRepository {
  NotificationRepository(super.apiService);

  @override
  String get basePath => '/api/notifications/notifications';

  Future<List<NotificationModel>> getNotifications() async {
    return await getList(NotificationModel.fromJson);
  }

  Future<NotificationModel> getNotificationById(String id) async {
    return await getById(id, NotificationModel.fromJson);
  }

  Future<NotificationModel> createNotification(
    Map<String, dynamic> data,
  ) async {
    return await create(data, NotificationModel.fromJson);
  }

  Future<NotificationModel> updateNotification(
    String id,
    Map<String, dynamic> data,
  ) async {
    return await update(id, data, NotificationModel.fromJson);
  }
}
