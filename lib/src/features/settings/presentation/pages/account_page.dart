import 'package:flutter/material.dart';
import '../../logic/account_controller.dart';
import '../widgets/settings_switch_tile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final controller = AccountController();

  @override
  Widget build(BuildContext context) {
    final s = controller.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [

          _sectionTitle("Security"),

          SettingsSwitchTile(
            title: "Security notifications",
            subtitle: "Receive notifications about account security",
            icon: Icons.security,
            value: s.securityNotifications,
            onChanged: (v) {
              setState(() {
                controller.toggleSecurityNotifications(v);
              });
            },
          ),

          SettingsSwitchTile(
            title: "Two-step verification",
            subtitle: "Add an extra layer of security",
            icon: Icons.lock,
            value: s.twoStepVerification,
            onChanged: (v) {
              setState(() {
                controller.toggleTwoStepVerification(v);
              });
            },
          ),

          _sectionTitle("Account Management"),

          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Change number"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showChangeNumberDialog();
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Request account info"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showSnack("Account info requested");
            },
          ),

          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text("Delete my account"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _confirmDelete();
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  void _showChangeNumberDialog() {
    final controllerText = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Number"),
        content: TextField(
          controller: controllerText,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: "Enter new number",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _showSnack("Number changed to ${controllerText.text}");
              Navigator.pop(context);
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _showSnack("Account deleted");
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
