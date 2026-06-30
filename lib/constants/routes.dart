/// This class provides a centralized location for defining route names,
/// making it easier to manage and reference them throughout the app.
/// Example usage:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:monet/constants/routes.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       initialRoute: Routes.login,
///       routes: {
///         Routes.login: (context) => LoginPage(),
///         Routes.register: (context) => RegisterPage(),
///       },
///     );
///   }
/// }
/// ```
class Routes {
  // Authentication
  static const String forgotPassword = '/forgot-password';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String otp = '/otp';
  static const String register = '/register';
  static const String resetPassword = '/reset-password';

  // Features
  static const String expenseTracker = '/expense-tracker';
  static const String home = '/home';
  static const String nfcScanner = '/nfc-scanner';
  static const String profile = '/profile';
  static const String settings = '/settings';
}