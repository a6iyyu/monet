import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:monet/constants/routes.dart';

/// A service class that handles user login functionality.
class LoginService {
  // Dio instance for making HTTP requests.
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.get('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Login function that takes a username and password, and returns a Future
  /// that resolves to a String (e.g., a token) or null if login fails.
  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(Routes.login, data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return response.data['data']['token'] as String?;
      }

      throw Exception('Failed to log in. Please check your credentials.');
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        throw Exception('Your email or password is incorrect. Where has your memory gone?');
      }

      throw Exception('An error occurred while trying to log in. Please try again later.');
    }
  }
}