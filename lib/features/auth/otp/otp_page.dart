import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  final String email;
  const OtpPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Enter the 6-digit code sent to your phone'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}