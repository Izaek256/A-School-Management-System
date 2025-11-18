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

class NotificationNotifier extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadNotifications() async {
    state = const AsyncValue.loading();
    try {
      final notifications = await _repository.getNotifications();
      state = AsyncValue.data(notifications);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<NotificationModel> createNotification(Map<String, dynamic> data) async {
    try {
      final notification = await _repository.createNotification(data);
      // Reload the list
      await loadNotifications();
      return notification;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationModel> updateNotification(String id, Map<String, dynamic> data) async {
    try {
      final notification = await _repository.updateNotification(id, data);
      // Reload the list
      await loadNotifications();
      return notification;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadNotifications();
    } catch (e) {
      rethrow;
    }
  }
}

final notificationNotifierProvider = StateNotifierProvider<NotificationNotifier, AsyncValue<List<NotificationModel>>>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});