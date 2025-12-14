import 'package:flutter/material.dart';
import '../../logic/notification_controller.dart';
import '../widgets/settings_switch_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final controller = NotificationController();

  @override
  Widget build(BuildContext context) {
    final s = controller.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [

          /// -------- GENERAL --------
          _sectionTitle("General"),

          SettingsSwitchTile(
            title: "Enable Notifications",
            subtitle: "Turn all notifications on or off",
            icon: Icons.notifications_active,
            value: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.toggleAll(v);
              });
            },
          ),

          /// -------- MESSAGES --------
          _sectionTitle("Messages"),

          SettingsSwitchTile(
            title: "Message tones",
            subtitle: "Play sound for messages",
            icon: Icons.message,
            value: s.messageTone,
            enabled: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.toggleMessage(v);
              });
            },
          ),

          SettingsSwitchTile(
            title: "Preview message",
            subtitle: "Show message content in notification",
            icon: Icons.visibility,
            value: s.preview,
            enabled: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.togglePreview(v);
              });
            },
          ),

          /// -------- GROUPS --------
          _sectionTitle("Groups"),

          SettingsSwitchTile(
            title: "Group notifications",
            subtitle: "Notify for group messages",
            icon: Icons.groups,
            value: s.groupNotification,
            enabled: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.toggleGroup(v);
              });
            },
          ),

          /// -------- CALLS --------
          _sectionTitle("Calls"),

          SettingsSwitchTile(
            title: "Call tones",
            subtitle: "Play sound for calls",
            icon: Icons.call,
            value: s.callTone,
            enabled: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.toggleCall(v);
              });
            },
          ),

          SettingsSwitchTile(
            title: "Vibration",
            subtitle: "Vibrate for incoming calls",
            icon: Icons.vibration,
            value: s.vibration,
            enabled: s.enabled,
            onChanged: (v) {
              setState(() {
                controller.toggleVibration(v);
              });
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
}
