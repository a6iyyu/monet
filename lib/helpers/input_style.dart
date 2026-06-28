import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A helper class that provides a consistent input decoration style for form fields.
/// Each input field will have a rounded border, a specific fill color, and a prefix icon.
/// Example usage:
/// ```dart
/// import 'package:monet/helpers/input_style.dart';
///
/// class MyFormField extends StatelessWidget {
///   final InputStyle _inputStyle = InputStyle();
///
///   @override
///   Widget build(BuildContext context) {
///     return TextFormField(
///       decoration: _inputStyle.input('Email', Icons.email),
///     );
///   }
/// }
class InputStyle {
  InputDecoration input(String label, IconData icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      fillColor: const Color(0xFFF8FAFC),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
      ),
      labelStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
      labelText: label,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Icon(icon, color: const Color(0xFF4F46E5)),
      ),
      prefixIconConstraints: const BoxConstraints(minHeight: 40, minWidth: 40),
    );
  }
}