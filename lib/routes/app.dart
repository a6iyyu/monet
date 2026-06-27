import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/features/auth/login/page.dart';
import 'package:monet/features/auth/register/page.dart';
import 'package:monet/features/dashboard/page.dart';
import 'package:monet/features/expense_tracker/page.dart';
import 'package:monet/features/nfc_scanner/page.dart';

part 'app.g.dart';

@TypedGoRoute<LoginRoute>(path: Routes.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Login();
}

@TypedGoRoute<RegisterRoute>(path: Routes.register)
class RegisterRoute extends GoRouteData with $RegisterRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Register();
}

@TypedGoRoute<HomeRoute>(path: Routes.home)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Dashboard();
}

@TypedGoRoute<ExpenseTrackerRoute>(path: Routes.expenseTracker)
class ExpenseTrackerRoute extends GoRouteData with $ExpenseTrackerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const ExpenseTracker();
}

@TypedGoRoute<NfcScannerRoute>(path: Routes.nfcScanner)
class NfcScannerRoute extends GoRouteData with $NfcScannerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const NfcScanner();
}