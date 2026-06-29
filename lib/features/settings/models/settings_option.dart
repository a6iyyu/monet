import 'package:flutter/material.dart';

/// Represents a single settings option in the settings list. This class
/// encapsulates the properties of a settings option, including its icon,
/// title, subtitle, trailing widget, tap callback, and optional icon color.
/// It is used to create a consistent and reusable representation of settings
/// options throughout the application.
///
/// Example usage:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:monet/features/settings/models/settings_option.dart';
///
/// class MySettingsPage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ListView(
///       children: [
///         SettingsOption(
///           icon: Icons.person,
///           title: 'Edit Profile',
///           subtitle: 'Username, email, phone number',
///           trailing: Icon(Icons.arrow_forward_ios, size: 16),
///         ),
///       ],
///     );
///   }
/// }
class SettingsOption {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const SettingsOption({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });
}