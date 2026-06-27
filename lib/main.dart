import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monet/routes/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Monet());
}

class Monet extends StatelessWidget {
  const Monet({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(routes: $appRoutes);

    return MaterialApp.router(
      title: 'Monet',
      routerConfig: router,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}