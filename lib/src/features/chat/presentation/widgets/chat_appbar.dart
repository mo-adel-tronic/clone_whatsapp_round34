import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_theme.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.black),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text("My friend",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(width: 6),
                  // verified badge
                  Icon(Icons.check_circle, size: 16, color: Colors.lightGreenAccent),
                ],
              ),
              const Text("Online",
                  style: TextStyle(fontSize: 13, color: Colors.white70)),
            ],
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.videocam, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.call, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.more_vert, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}