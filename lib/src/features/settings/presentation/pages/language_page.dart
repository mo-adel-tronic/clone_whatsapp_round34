
import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App language"),
        backgroundColor: Colors.teal,
      ),
      body: const Center(child: Text("Select your language")),
    );
  }
}