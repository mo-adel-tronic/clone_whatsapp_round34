
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: const [
          ListTile(title: Text("Block contacts")),
          ListTile(title: Text("Disappearing messages")),
        ],
      ),
    );
  }
}