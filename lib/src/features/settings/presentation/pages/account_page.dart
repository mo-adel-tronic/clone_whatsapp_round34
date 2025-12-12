
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Security notifications"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
          ListTile(
            title: Text("Change number"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
        ],
      ),
    );
  }
}