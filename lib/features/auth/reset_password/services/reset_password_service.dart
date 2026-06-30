import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/utils/log.dart';

class ResetPasswordService {
  late final Dio _dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<void> handleResetPassword({ required BuildContext context, required String token, required String newPassword }) async {
    try {
      final response = await _dio.post(Routes.resetPassword, data: {'token': token, 'new_password': newPassword});

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password. Please try again.');
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Password has been successfully reset! You can now log in.'),
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

      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        errorMessage = 'Invalid or expired token. Please request a new password reset link.';
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