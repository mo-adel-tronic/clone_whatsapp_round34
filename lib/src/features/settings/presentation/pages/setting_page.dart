import 'package:flutter/material.dart';
import 'account_page.dart';
import 'privacy_page.dart';
import 'avatar_page.dart';
import 'notifications_page.dart';
import 'storage_page.dart';
import 'language_page.dart';
import 'help_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Settings",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          //---------------- PROFILE HEADER ------------------
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300?img=3"), // صورة شبه اللي في المثال
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Leo Das",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("POC ",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const Icon(Icons.qr_code, size: 30),
              const SizedBox(width: 10),
              const Icon(Icons.keyboard_arrow_down, size: 30)
            ],
          ),

          const SizedBox(height: 20),

          //---------------- SETTINGS ITEMS ------------------
          buildItem(
            context,
            icon: Icons.key,
            title: "Account",
            subtitle: "Security notifications, change number",
            page: const AccountPage(),
          ),

          buildItem(
            context,
            icon: Icons.lock,
            title: "Privacy",
            subtitle: "Block contacts, disappearing messages",
            page: const PrivacyPage(),
          ),

          buildItem(
            context,
            icon: Icons.person,
            title: "Avatar",
            subtitle: "Create, edit, profile photo",
            page: const AvatarPage(),
          ),

          buildItem(
            context,
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Message, group & call tones",
            page: const NotificationsPage(),
          ),

          buildItem(
            context,
            icon: Icons.storage,
            title: "Storage",
            subtitle: "Network usage, auto-download",
            page: const StoragePage(),
          ),

          buildItem(
            context,
            icon: Icons.language,
            title: "App language",
            subtitle: "English (device's language)",
            page: const LanguagePage(),
          ),

          buildItem(
            context,
            icon: Icons.help,
            title: "Help",
            subtitle: "Help centre, contact us, privacy policy",
            page: const HelpPage(),
          ),

          const SizedBox(height: 15),

          Row(
            children: const [
              Icon(Icons.group, color: Colors.grey),
              SizedBox(width: 20),
              Text("Invite a friend", style: TextStyle(fontSize: 17)),
            ],
          ),

          const SizedBox(height: 15),
          Center(
            child: Column(
              children: const [
                Text("from", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Icon(Icons.facebook, size: 30),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Reusable settings item
  Widget buildItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontSize: 17)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}