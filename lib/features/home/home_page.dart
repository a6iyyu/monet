import 'package:flutter/material.dart';
import 'package:monet/features/home/services/home_notification_service.dart';
import 'package:monet/features/home/widgets/home_header.dart';
import 'package:monet/features/home/widgets/home_notification_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeNotificationService _notificationService = HomeNotificationService();

  final String _currentUsername = "Rafi";

  List<String> _notifications = [];
  bool _hasUnreadNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final data = await _notificationService.fetchNotifications();
    if (!mounted) return;

    setState(() {
      _notifications = data;
      _hasUnreadNotifications = data.isNotEmpty;
    });
  }

  void _showNotificationPopup() {
    setState(() => _hasUnreadNotifications = false);

    // Show the notification sheet in a modal bottom sheet
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      builder: (context) => HomeNotificationSheet(notifications: _notifications),
      context: context,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(
                hasUnread: _hasUnreadNotifications,
                onNotificationTap: _showNotificationPopup,
                username: _currentUsername,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}