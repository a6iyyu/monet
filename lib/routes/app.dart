import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/features/auth/forgot-password/page.dart';
import 'package:monet/features/auth/login/page.dart';
import 'package:monet/features/auth/register/page.dart';
import 'package:monet/features/auth/reset-password/page.dart';
import 'package:monet/features/dashboard/page.dart';
import 'package:monet/features/expense_tracker/page.dart';
import 'package:monet/features/nfc_scanner/page.dart';

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

@TypedGoRoute<RegisterRoute>(path: Routes.register)
class RegisterRoute extends GoRouteData with $RegisterRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const RegisterPage();
}

@TypedGoRoute<ResetPasswordRoute>(path: Routes.resetPassword)
class ResetPasswordRoute extends GoRouteData with $ResetPasswordRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ResetPasswordPage();
}

// =============================================
// Features
// =============================================

@TypedGoRoute<HomeRoute>(path: Routes.home)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const DashboardPage();
}

@TypedGoRoute<ExpenseTrackerRoute>(path: Routes.expenseTracker)
class ExpenseTrackerRoute extends GoRouteData with $ExpenseTrackerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ExpenseTrackerPage();
}

@TypedGoRoute<NfcScannerRoute>(path: Routes.nfcScanner)
class NfcScannerRoute extends GoRouteData with $NfcScannerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const NfcScannerPage();
}