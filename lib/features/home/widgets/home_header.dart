import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/routes/app.dart';

class HomeHeader extends StatelessWidget {
  final String username;
  final bool hasUnread;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.username,
    required this.hasUnread,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => ProfileRoute().push(context),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF4F46E5),
                radius: 20,
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  username,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0F172A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Stack(
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey.shade800,
                size: 28,
              ),
            ),

            if (hasUnread)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  height: 10,
                  width: 10,
                ),
              ),
          ],
        ),
      ],
    );
  }
}