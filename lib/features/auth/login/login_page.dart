import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/features/auth/login/widgets/login_form.dart';
import 'package:monet/routes/app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  'Monet',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0F172A),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Take control of your finances\nbefore they take control of you.',
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
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withValues(alpha: 0.03),
                        offset: const Offset(0, 10),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: const LoginForm(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(onChanged: (value) {}, value: false),
                        Text(
                          'Remember me',
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => ForgotPasswordRoute().push(context),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF4F46E5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFF1877F2),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFDB4437),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: const FaIcon(
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
                      "Don't have an account?",
                      style: GoogleFonts.poppins(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () => RegisterRoute().push(context),
                      child: Text(
                        'Sign Up',
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