class AnnouncementModel {
  bool success;
  List<Announcement> message;

  AnnouncementModel({required this.success, required this.message});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      success: json['success'],
      message: (json['message'] as List)
          .map((item) => Announcement.fromJson(item))
          .toList(),
    );
  }
}

class Announcement {
  int id;
  String announcement;
  String userId;
  String createdAt;
  String updatedAt;

  Announcement({
    required this.id,
    required this.announcement,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      announcement: json['announcement'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
