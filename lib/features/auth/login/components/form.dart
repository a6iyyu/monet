import 'package:flutter/material.dart';

class Form extends StatelessWidget {
  const Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Kata Sandi'),
          obscureText: true,
        ),
      ],
    );
  }
}