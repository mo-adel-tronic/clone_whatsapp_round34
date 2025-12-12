
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: const [
          ListTile(title: Text("Help centre")),
          ListTile(title: Text("Contact us")),
          ListTile(title: Text("Privacy policy")),
        ],
      ),
    );
  }
}