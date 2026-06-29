import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monet/constants/routes.dart';
import 'package:monet/core/security/secure_storage.dart';
import 'package:monet/core/services/region.dart';
import 'package:monet/features/auth/register/services/register_service.dart';
import 'package:monet/helpers/input_style.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Final variables for form key.
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields.
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _countryController = TextEditingController();
  final _defaultCurrencyController = TextEditingController();

  final _inputStyle = InputStyle(); // Instance of input style to be used in the form.
  final _registerService = RegisterService(); // Instance of register service to handle registration.

  final _storage = SecureStorage(); // Instance of secure storage to handle token storage.
  bool _isLoading = false; // State variable to indicate if a registration request is in progress.
  bool _obscurePassword = true; // State variable to toggle password visibility.
  bool _obscureConfirmPassword = true; // State variable to toggle confirm password visibility.

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return; // Validate the form fields before proceeding.
    setState(() => _isLoading = true);

    try {
      final token = await _registerService.register(
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        country: _countryController.text,
        defaultCurrency: _defaultCurrencyController.text,
      );

      if (token == null) throw Exception('Registration failed, please try again.');
      await _storage.saveToken(token); // Store the token securely with the key 'token'.

      // Stop the execution if the widget is no longer mounted to avoid memory leaks.
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Registration successful!'),
        ),
      );

      context.go(Routes.otp, extra: _emailController.text);
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

  // Default function to dispose of the controllers when the widget is removed
  // from the widget tree to free up resources and avoid memory leaks.
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _countryController.dispose();
    _defaultCurrencyController.dispose();
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
            controller: _fullNameController,
            decoration: _inputStyle.input('Full Name', Icons.person),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your full name.';
              if (value.length < 3) return 'Full name must be at least 3 characters long.';
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: _inputStyle.input('Email', Icons.email),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Please enter a valid email address';
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: _inputStyle.input('Password', Icons.lock).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your password.';
              if (value.length < 8) return 'Password must be at least 8 characters long.';
              if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) return 'Password must contain at least one letter and one number.';
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: _inputStyle.input('Confirm Password', Icons.lock).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please confirm your password.';
              if (value != _passwordController.text) return 'Passwords do not match.';
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DropdownSearch<String>(
                  decoratorProps: DropDownDecoratorProps(decoration: _inputStyle.input('Country', Icons.flag)),
                  items: (filter, loadProps) async => await Region().getCountries(),
                  onSelected: (value) => _countryController.text = value ?? '',
                  popupProps: const PopupProps.menu(
                    searchFieldProps: TextFieldProps(decoration: InputDecoration(hintText: 'Search country...')),
                    showSearchBox: true,
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                )
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownSearch<String>(
                  decoratorProps: DropDownDecoratorProps(decoration: _inputStyle.input('Currency', Icons.attach_money)),
                  items: (filter, loadProps) async => await Region().getCurrencies(),
                  onSelected: (value) => _defaultCurrencyController.text = value ?? '',
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(decoration: InputDecoration(hintText: 'Search currency...')),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2
                ),
              )
              : Text(
                'Register',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
            ),
          ),
        ],
      ),
    );
  }
}