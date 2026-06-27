import 'package:flutter/material.dart';

class NfcScanner extends StatefulWidget {
  const NfcScanner({super.key});

  @override
  State<NfcScanner> createState() => _NfcScannerState();
}

class _NfcScannerState extends State<NfcScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NFC Scanner')),
      body: const Center(child: Text('NFC Scanner Page')),
    );
  }
}