import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/helpers/input_style.dart';
import 'package:monet/features/auth/forgot_password/services/forgot_password_service.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _inputStyle = InputStyle();
  final _forgotPasswordService = ForgotPasswordService();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await _forgotPasswordService.handleForgotPassword(context: context, email: _emailController.text);

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
            controller: _emailController,
            decoration: _inputStyle.input('Email Address', Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.poppins(color: const Color(0xFF0F172A)),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text('Send Reset Link', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}