import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/core/security/secure_storage.dart';
import 'package:monet/features/auth/register/models/register_request.dart';
import 'package:monet/utils/log.dart';

/// A service class that handles user registration functionality.
class RegisterService {
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final SecureStorage _storage = SecureStorage();

  Future<void> handleRegister({ required BuildContext context, required RegisterRequest request }) async {
    try {
      final response = await _dio.post(Routes.register, data: request.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Registration completed, but received an unexpected response.');
      }

      final token = response.data['data']['token'] as String?;

      if (token == null) {
        throw Exception('Registration failed, invalid token received.');
      }

      await _storage.saveToken(token);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Registration successful!'),
        ),
      );

      context.go(Routes.otp, extra: request.email);
    } on DioException catch (e) {
      String errorMessage = 'An unexpected error occurred during registration.';
      final statusCode = e.response?.statusCode;

      if (e.response == null) {
        Log.error('Network Error: ${e.message}', e);
        errorMessage = 'Network error. Please check your internet connection.';
      }

      if (statusCode == 409) {
        errorMessage = 'This email is already registered. Try logging in instead.';
      }

      if (statusCode == 400 || statusCode == 422) {
        errorMessage = 'Invalid data provided. Please check your input fields.';
      }

      if (statusCode == 500) {
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