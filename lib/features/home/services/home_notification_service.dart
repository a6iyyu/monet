import 'package:dio/dio.dart';
import 'package:monet/features/home/models/home_notification_model.dart';
import 'package:monet/utils/log.dart';

/// A service class for fetching notifications in the dashboard feature.
class HomeNotificationService {
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Fetches notifications from the API. Returns a list of notification
  /// strings or an empty list in case of an error.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/features/home/services/home_notification_service.dart';
  ///
  /// final service = HomeNotificationService();
  /// final notifications = await service.fetchNotifications();
  /// ```
  Future<List<String>> fetchNotifications() async {
    const List<String> fallbackNotifications = [
      'Welcome to Monet! Start tracking your expenses today.',
      'NFC Card successfully linked to your account.',
      'You have spent 80% of your food budget this month.',
    ];

    try {
      final response = await _dio.get('/notifications');

      if (response.statusCode != 200 || response.data == null) {
        Log.error('Failed to fetch notifications: Status ${response.statusCode}');
        return fallbackNotifications;
      }

      if (response.data is! Map<String, dynamic>) {
        Log.error('Invalid JSON structure: Expected Map.');
        return fallbackNotifications;
      }

      final notificationModel = HomeNotificationModel.fromJson(response.data as Map<String, dynamic>);
      return notificationModel.notifications;
    } on DioException catch (e) {
      Log.error('DioException on fetch notifications: ${e.message}', e);
      return fallbackNotifications;
    } catch (e) {
      Log.error('Parsing error on fetch notifications: $e');
      return fallbackNotifications;
    }
  }
}