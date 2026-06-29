import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/features/auth/register/widgets/register_form.dart';
import 'package:monet/routes/app.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  height: 80,
                  image: const AssetImage('logo.png'),
                  semanticLabel: 'Monet Logo',
                  width: 80,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF4F46E5),
                    size: 56,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0F172A),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join Monet and start tracking\nyour expenses effortlessly.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
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
                  child: const RegisterForm(),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 16,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      'OR CONTINUE WITH',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 8,
                        endIndent: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue.shade800,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.poppins(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () => LoginRoute().push(context),
                      child: Text(
                        'Sign In',
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