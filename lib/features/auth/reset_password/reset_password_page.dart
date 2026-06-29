import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/features/auth/reset_password/widgets/reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  final String token;
  const ResetPasswordPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    // Scaffold ditambahkan di sini sebagai fondasi
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 100,
                  image: const AssetImage('logo.png'),
                  semanticLabel: 'Monet Logo',
                  width: 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.lock_reset_outlined,
                    color: Color(0xFF4F46E5),
                    size: 64,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0F172A),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your new password below.',
                  style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withValues(alpha: 0.03),
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: ResetPasswordForm(token: token),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}