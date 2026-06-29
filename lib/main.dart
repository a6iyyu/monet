import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/routes/app.dart';

/// Entry point of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Monet());
}

class Monet extends StatelessWidget {
  const Monet({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: Routes.login,
      routes: $appRoutes,
    );

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(primarySwatch: Colors.indigo),
      title: 'Monet',
    );
  }
}