import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/announcement.dart';
import 'package:frontend/repositories/announcement_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AnnouncementRepository(apiService);
});

final announcementsProvider = FutureProvider<List<Announcement>>((ref) async {
  final repository = ref.watch(announcementRepositoryProvider);
  return await repository.getAnnouncements();
});

final announcementProvider = FutureProvider.family<Announcement, String>((ref, id) async {
  final repository = ref.watch(announcementRepositoryProvider);
  return await repository.getAnnouncementById(id);
});

class AnnouncementNotifier extends StateNotifier<AsyncValue<List<Announcement>>> {
  final AnnouncementRepository _repository;

  AnnouncementNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadAnnouncements() async {
    state = const AsyncValue.loading();
    try {
      final announcements = await _repository.getAnnouncements();
      state = AsyncValue.data(announcements);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Announcement> createAnnouncement(Map<String, dynamic> data) async {
    try {
      final announcement = await _repository.createAnnouncement(data);
      // Reload the list
      await loadAnnouncements();
      return announcement;
    } catch (e) {
      rethrow;
    }
  }

  Future<Announcement> updateAnnouncement(String id, Map<String, dynamic> data) async {
    try {
      final announcement = await _repository.updateAnnouncement(id, data);
      // Reload the list
      await loadAnnouncements();
      return announcement;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadAnnouncements();
    } catch (e) {
      rethrow;
    }
  }
}

final announcementNotifierProvider = StateNotifierProvider<AnnouncementNotifier, AsyncValue<List<Announcement>>>((ref) {
  final repository = ref.watch(announcementRepositoryProvider);
  return AnnouncementNotifier(repository);
});