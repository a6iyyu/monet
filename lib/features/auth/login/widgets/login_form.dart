import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/features/auth/login/services/login_service.dart';
import 'package:monet/helpers/input_style.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Final variables for form key.
  final _formKey = GlobalKey<FormState>();

  // Controllers for the email and password input fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instances of input style and login service to be used in the form.
  final _inputStyle = InputStyle();
  final _loginService = LoginService();

  bool _isLoading = false; // State variable to indicate if a login request is in progress.
  bool _obscurePassword = true; // State variable to toggle password visibility.

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return; // Validate the form fields before proceeding.

    setState(() => _isLoading = true);

    try {
      final token = await _loginService.login(_emailController.text, _passwordController.text);
      if (token == null) throw Exception('Invalid credentials, please try again.');

      // Store the token securely with the key 'token'.
      await const FlutterSecureStorage().write(key: 'token', value: token);

      // Stop the execution if the widget is no longer mounted to avoid memory leaks.
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Login successful!'),
        ),
      );

      context.go(Routes.home);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.toString().replaceAll('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Function to handle login when the form is submitted.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: _inputStyle.input('Email', Icons.email),
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.poppins(color: const Color(0xFF0F172A)),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
              if (value.length < 5) return 'Email must be at least 5 characters long';
              if (value.length > 50) return 'Email cannot be longer than 50 characters';
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: _inputStyle.input('Password', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            obscureText: _obscurePassword,
            style: GoogleFonts.poppins(color: const Color(0xFF0F172A)),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your password';
              if (value.length < 8) return 'Password must be at least 8 characters long';
              if (value.length > 100) return 'Password cannot be longer than 100 characters';
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text('Login', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}