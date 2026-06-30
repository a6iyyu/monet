import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNotificationSheet extends StatelessWidget {
  final List<String> notifications;

  // Notification sheet need to be passed a list of notifications to display
  const HomeNotificationSheet({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'No new notifications.',
            style: GoogleFonts.poppins(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Notifications',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xFF4F46E5),
                      size: 20,
                    ),
                  ),
                  title: Text(
                    notifications[index],
                    style: GoogleFonts.poppins(color: const Color(0xFF0F172A), fontSize: 14),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}