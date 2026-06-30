class HomeNotificationModel {
  final List<String> notifications;
  final int status;

  HomeNotificationModel({required this.notifications, required this.status});

  factory HomeNotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == null || json['data'] == null) {
      throw Exception('There is a problem with the notification data.');
    }

    if (json['data'] is! List) {
      throw Exception('The notification data is not in the expected format.');
    }

    final List<dynamic> rawData = json['data'];
    final List<String> parsedNotifications = rawData.map((item) => item.toString()).where((text) => text.isNotEmpty).toList();

    return HomeNotificationModel(
      notifications: parsedNotifications,
      status: json['status'] as int,
    );
  }
}