import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/chose_container_section.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/container_home_widget.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatelessWidget {
  final String searchText; // نص البحث
  const ChatsList({super.key, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    // قائمة البيانات
    final chats = [
      {
        "userName": 'Madan Gowri',
        "subtitle": 'Hello My MG Squad!',
        "profileImage": "assets/images/profile_image_home/1.png",
        "date": "12:41 AM",
        "isSent": true,
        "isSeen": true,
      },
      {
        "userName": 'Monish',
        "subtitle": 'How are You?',
        "profileImage": "assets/images/profile_image_home/2.png",
        "date": "2:00 AM",
        "isSent": true,
        "unreadMessage": "3",
      },
      {
        "userName": 'Dad',
        "subtitle": 'You reacted 👍to: Done! ',
        "profileImage": "assets/images/profile_image_home/3.png",
        "date": "5:00 PM",
      },
      {
        "userName": 'Narendra Modi',
        "subtitle": 'Should I call you now?',
        "profileImage": "assets/images/profile_image_home/4.png",
        "date": "Yesterday",
        "isSent": true,
        "isSeen": true,
        "unreadMessage": "2",
      },
      {
        "userName": 'Madan Gowri',
        "subtitle": 'Hello My MG Squad!',
        "profileImage": "assets/images/profile_image_home/3.png",
        "date": "12:41 AM",
        "isSent": true,
        "isSeen": true,
      },
      {
        "userName": 'Monish',
        "subtitle": 'How are You?',
        "profileImage": "assets/images/profile_image_home/2.png",
        "date": "2:00 AM",
        "isSent": true,
        "unreadMessage": "3",
      },
      {
        "userName": 'Dad',
        "subtitle": 'You reacted 👍to: Done! ',
        "profileImage": "assets/images/profile_image_home/1.png",
        "date": "5:00 PM",
      },
      {
        "userName": 'Narendra Modi',
        "subtitle": 'Should I call you now?',
        "profileImage": "assets/images/profile_image_home/4.png",
        "date": "Yesterday",
        "isSent": true,
        "isSeen": true,
        "unreadMessage": "2",
      },
    ];

    // فلترة حسب البحث
    final filteredChats = chats
        .where((chat) => (chat['userName'] as String)
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return ListView(
      children: filteredChats.map((chat) {
        return ContainerHomeWidget(
          userName: chat['userName'] as String,
          subtitle: chat['subtitle'] as String,
          profileImage: chat['profileImage'] as String,
          date: chat['date'] as String,
          isSent: chat['isSent'] as bool? ?? false,
          isSeen: chat['isSeen'] as bool? ?? false,
          unreadMessage: chat['unreadMessage'] as String?,
          section: ChoseContainerSection.chat,
        );
      }).toList(),
    );
  }
}
