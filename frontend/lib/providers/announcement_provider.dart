import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/announcement.dart';
import 'package:frontend/repositories/announcement_repository.dart';
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

class AnnouncementNotifier extends AsyncNotifier<List<Announcement>> {
  late final AnnouncementRepository _repository;

  @override
  Future<List<Announcement>> build() async {
    _repository = ref.read(announcementRepositoryProvider);
    return await _loadAnnouncements();
  }

  Future<List<Announcement>> _loadAnnouncements() async {
    return await _repository.getAnnouncements();
  }

  Future<Announcement> createAnnouncement(Map<String, dynamic> data) async {
    try {
      final announcement = await _repository.createAnnouncement(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAnnouncements());
      return announcement;
    } catch (e) {
      rethrow;
    }
  }

  Future<Announcement> updateAnnouncement(String id, Map<String, dynamic> data) async {
    try {
      final announcement = await _repository.updateAnnouncement(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAnnouncements());
      return announcement;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadAnnouncements());
    } catch (e) {
      rethrow;
    }
  }
}

final announcementNotifierProvider = AsyncNotifierProvider<AnnouncementNotifier, List<Announcement>>(AnnouncementNotifier.new);