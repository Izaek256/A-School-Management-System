import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/announcement.dart';

class AnnouncementRepository extends BaseRepository {
  AnnouncementRepository(ApiService apiService) : super(apiService);

  @override
  String get basePath => '/announcements';

  Future<List<Announcement>> getAnnouncements() async {
    return await getList(Announcement.fromJson);
  }

  Future<Announcement> getAnnouncementById(String id) async {
    return await getById(id, Announcement.fromJson);
  }

  Future<Announcement> createAnnouncement(Map<String, dynamic> data) async {
    return await create(data, Announcement.fromJson);
  }

  Future<Announcement> updateAnnouncement(String id, Map<String, dynamic> data) async {
    return await update(id, data, Announcement.fromJson);
  }
}