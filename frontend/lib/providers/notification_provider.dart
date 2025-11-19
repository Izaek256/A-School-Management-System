import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/notification.dart';
import 'package:frontend/repositories/notification_repository.dart';
import 'package:frontend/providers/api_service_provider.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NotificationRepository(apiService);
});

final notificationsProvider = FutureProvider<List<NotificationModel>>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return await repository.getNotifications();
});

final notificationProvider = FutureProvider.family<NotificationModel, String>((ref, id) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return await repository.getNotificationById(id);
});

class NotificationNotifier extends AsyncNotifier<List<NotificationModel>> {
  late final NotificationRepository _repository;

  @override
  Future<List<NotificationModel>> build() async {
    _repository = ref.read(notificationRepositoryProvider);
    return await _loadNotifications();
  }

  Future<List<NotificationModel>> _loadNotifications() async {
    return await _repository.getNotifications();
  }

  Future<NotificationModel> createNotification(Map<String, dynamic> data) async {
    try {
      final notification = await _repository.createNotification(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadNotifications());
      return notification;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationModel> updateNotification(String id, Map<String, dynamic> data) async {
    try {
      final notification = await _repository.updateNotification(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadNotifications());
      return notification;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadNotifications());
    } catch (e) {
      rethrow;
    }
  }
}

final notificationNotifierProvider = AsyncNotifierProvider<NotificationNotifier, List<NotificationModel>>(NotificationNotifier.new);