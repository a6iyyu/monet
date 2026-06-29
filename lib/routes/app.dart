import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/features/auth/forgot_password/forgot_password_page.dart';
import 'package:monet/features/auth/login/login_page.dart';
import 'package:monet/features/auth/otp/otp_page.dart';
import 'package:monet/features/auth/register/register_page.dart';
import 'package:monet/features/auth/reset_password/reset_password_page.dart';
import 'package:monet/features/dashboard/dashboard_page.dart';
import 'package:monet/features/expense_tracker/expense_tracker_page.dart';
import 'package:monet/features/nfc_scanner/nfc_scanner_page.dart';
import 'package:monet/features/profile/profile_page.dart';
import 'package:monet/features/settings/settings_page.dart';

part 'app.g.dart';

// =============================================
// Authentication
// =============================================

@TypedGoRoute<ForgotPasswordRoute>(path: Routes.forgotPassword)
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ForgotPasswordPage();
}

@TypedGoRoute<LoginRoute>(path: Routes.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<OtpRoute>(path: Routes.otp)
class OtpRoute extends GoRouteData with $OtpRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final String email = state.uri.queryParameters['email'] ?? '';
    return OtpPage(email: email);
  }
}

@TypedGoRoute<RegisterRoute>(path: Routes.register)
class RegisterRoute extends GoRouteData with $RegisterRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const RegisterPage();
}

@TypedGoRoute<ResetPasswordRoute>(path: Routes.resetPassword)
class ResetPasswordRoute extends GoRouteData with $ResetPasswordRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final String token = state.uri.queryParameters['token'] ?? '';

    if (token.isEmpty) {
      return const LoginPage();
    }

    return ResetPasswordPage(token: token);
  }
}

// =============================================
// Features
// =============================================

@TypedGoRoute<ExpenseTrackerRoute>(path: Routes.expenseTracker)
class ExpenseTrackerRoute extends GoRouteData with $ExpenseTrackerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ExpenseTrackerPage();
}

@TypedGoRoute<HomeRoute>(path: Routes.home)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const DashboardPage();
}

@TypedGoRoute<NfcScannerRoute>(path: Routes.nfcScanner)
class NfcScannerRoute extends GoRouteData with $NfcScannerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const NfcScannerPage();
}

@TypedGoRoute<ProfileRoute>(path: Routes.profile)
class ProfileRoute extends GoRouteData with $ProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();
}

@TypedGoRoute<SettingsRoute>(path: Routes.settings)
class SettingsRoute extends GoRouteData with $SettingsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsPage();
}