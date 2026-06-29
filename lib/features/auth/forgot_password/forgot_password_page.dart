import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/features/auth/forgot_password/widgets/forgot_password_form.dart';
import 'package:monet/routes/app.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF4F46E5),
                    size: 64,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Forgot Password',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0F172A),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your email address to reset your password.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    height: 1.5,
                  ),
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
                  child: const ForgotPasswordForm(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember your password?',
                      style: GoogleFonts.poppins(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () => LoginRoute().push(context),
                      child: Text(
                        'Back to Login',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF4F46E5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}