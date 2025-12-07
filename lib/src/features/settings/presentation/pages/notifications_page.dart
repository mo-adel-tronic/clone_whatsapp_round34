import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: const [
          ListTile(title: Text("Message tones")),
          ListTile(title: Text("Group notifications")),
          ListTile(title: Text("Call tones")),
        ],
      ),
    );
  }
}