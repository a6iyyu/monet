import 'package:dio/dio.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/utils/log.dart';
import 'package:monet/features/auth/login/models/login_response.dart';

/// A service class that handles user login functionality.
class LoginService {
  // Dio instance for making HTTP requests.
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000/'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Login function that takes a username and password, and returns a Future
  /// that resolves to a String (e.g., a token) or null if login fails.
  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(Routes.login, data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        final loginData = LoginResponse.fromJson(response.data);
        return loginData.token;
      }

      throw Exception('Failed to log in. Please check your credentials.');
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        Log.error('DioException on login: ${e.message}', e);
        throw Exception('Your email or password is incorrect. Where has your memory gone?');
      }

      throw Exception('An error occurred while trying to log in. Please try again later.');
    }
  }
}