import 'package:dio/dio.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/utils/log.dart';

/// A service class that handles user registration functionality.
class RegisterService {
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000/'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
    required String country,
    required String defaultCurrency,
  }) async {
    try {
      final response = await _dio.post(
        Routes.register,
        data: {
          'full_name': fullName,
          'email': email,
          'password': password,
          'country': country,
          'default_currency': defaultCurrency,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data']['token'] as String?;
      }

      throw Exception('Registration completed, but received an unexpected response.');
    } on DioException catch (e) {
      if (e.response == null) {
        Log.error('DioException on register response is null: ${e.message}', e);
        throw Exception('Network error. Please check your internet connection.');
      }

      final statusCode = e.response?.statusCode;

      if (statusCode == 409) {
        Log.error('DioException on register response is 409: ${e.message}', e);
        throw Exception('This email is already registered. Try logging in instead.');
      }

      if (statusCode == 400 || statusCode == 422) {
        Log.error('DioException on register response is 400/422: ${e.message}', e);
        throw Exception('Invalid data provided. Please check your input fields.');
      }

      if (statusCode == 500) {
        Log.error('DioException on register response is 500: ${e.message}', e);
        throw Exception('Our servers are currently experiencing issues. Please try again later.');
      }

      Log.error('DioException on register: ${e.message}', e);
      throw Exception('An unexpected error occurred during registration.');
    }
  }
}