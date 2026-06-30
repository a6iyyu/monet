import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/core/security/secure_storage.dart';
import 'package:monet/features/auth/login/models/login_request.dart';
import 'package:monet/features/auth/login/models/login_response.dart';
import 'package:monet/utils/log.dart';

/// A service class that handles user login functionality.
class LoginService {
  // Dio instance for making HTTP requests.
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final SecureStorage _storage = SecureStorage();

  Future<void> handleLogin({ required BuildContext context, required String email, required String password }) async {
    try {
      final payload = LoginRequest(username: email, password: password);
      final response = await _dio.post(Routes.login, data: payload.toJson());

      if (response.statusCode != 200) {
        throw Exception('Failed to log in. Please check your credentials.');
      }

      final loginData = LoginResponse.fromJson(response.data);
      await _storage.saveToken(loginData.token);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Login successful!'),
        ),
      );

      context.go(Routes.home);
    } on DioException catch (e) {
      String errorMessage = 'An error occurred while trying to log in. Please try again later.';
      final statusCode = e.response?.statusCode;

      if (e.response == null) {
        Log.error('Network Error: ${e.message}', e);
        errorMessage = 'Network error. Please check your internet connection.';
      }

      if (statusCode == 401) {
        Log.error('DioException on login 401: ${e.message}', e);
        errorMessage = 'Your email or password is incorrect. Where has your memory gone?';
      }

      if (statusCode == 500) {
        Log.error('DioException on login 500: ${e.message}', e);
        errorMessage = 'Our servers are currently experiencing issues. Please try again later.';
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(errorMessage),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.toString().replaceAll('Exception: ', '')),
        ),
      );
    }
  }
}