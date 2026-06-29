import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/features/auth/reset_password/services/reset_password_service.dart';
import 'package:monet/helpers/input_style.dart';

class ResetPasswordForm extends StatefulWidget {
  final String token;
  const ResetPasswordForm({super.key, required this.token});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  // Form key to validate the form
  final _formKey = GlobalKey<FormState>();

  // Controllers for the password and confirm password fields
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Instantiate the classes for input styling and reset password service
  final _inputStyle = InputStyle();
  final _resetPasswordService = ResetPasswordService();

  // State variables to manage loading state and password visibility
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await _resetPasswordService.handleResetPassword(context: context, token: widget.token, newPassword: _passwordController.text);

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _passwordController,
            decoration: _inputStyle.input('New Password', Icons.lock_outline).copyWith(
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
              if (value == null || value.isEmpty) return 'Please enter your new password.';
              if (value.length < 8) return 'Password must be at least 8 characters long.';
              if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) return 'Password must contain at least one letter and one number.';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: _inputStyle.input('Confirm Password', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
            obscureText: _obscureConfirmPassword,
            style: GoogleFonts.poppins(color: const Color(0xFF0F172A)),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please confirm your new password.';
              if (value != _passwordController.text) return 'Passwords do not match.';
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 0,
              minimumSize: const Size.fromHeight(56),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text('Update Password', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}