import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/utils/log.dart';

/// Service class to handle forgot password functionality, including sending a
/// password reset request to the backend API and handling responses.
class ForgotPasswordService {
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000/'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<void> handleForgotPassword({ required BuildContext context, required String email }) async {
    try {
      final response = await _dio.post(Routes.forgotPassword, data: {'email': email});

      if (response.statusCode != 200) {
        throw Exception('Failed to send reset link. Please try again.');
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Password reset link has been sent to your email.'),
        ),
      );

      context.go(Routes.login);
    } on DioException catch (e) {
      String errorMessage = 'An unexpected error occurred.';
      final statusCode = e.response?.statusCode;

      if (e.response == null) {
        Log.error('Network Error: ${e.message}', e);
        errorMessage = 'Network error. Please check your internet connection.';
      }

      if (statusCode == 404) {
        errorMessage = 'This email is not registered in our system.';
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