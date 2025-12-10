import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/chose_container_section.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/container_home_widget.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  final String searchText; // نص البحث
  const GroupList({super.key, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    // قائمة البيانات
    final groups = [
      {
        "userName": 'Madan Gowri',
        "subtitle": 'Hello My MG Squad!',
        "profileImage": "assets/images/profile_image_home/1.png",
        "date": "12:41 AM",
 
      },
      {
        "userName": 'Monish',
        "subtitle": 'How are You?',
        "profileImage": "assets/images/profile_image_home/2.png",
        "date": "2:00 AM",
    
      },
      {
        "userName": 'Dad',
        "subtitle": 'Yes of Course!',
        "profileImage": "assets/images/profile_image_home/3.png",
        "date": "5:00 PM",
      },
      {
        "userName": 'Narendra Modi',
        "subtitle": 'Should I call you now?',
        "profileImage": "assets/images/profile_image_home/4.png",
        "date": "Yesterday",

      },
      {
        "userName": 'Madan Gowri',
        "subtitle": 'Hello My MG Squad!',
        "profileImage": "assets/images/profile_image_home/3.png",
        "date": "12:41 AM",
     
      },
      {
        "userName": 'Monish',
        "subtitle": 'How are You?',
        "profileImage": "assets/images/profile_image_home/2.png",
        "date": "2:00 AM",
    
      },
      {
        "userName": 'Dad',
        "subtitle": 'Yes of Course!',
        "profileImage": "assets/images/profile_image_home/1.png",
        "date": "5:00 PM",
      },
      {
        "userName": 'Narendra Modi',
        "subtitle": 'Should I call you now?',
        "profileImage": "assets/images/profile_image_home/4.png",
        "date": "Yesterday",
     
      },
    ];

    // فلترة حسب البحث
    final filteredgroups = groups
        .where((group) => (group['userName'] as String)
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return ListView(
      children: filteredgroups.map((group) {
        return ContainerHomeWidget(
          userName: group['userName'] as String,
          subtitle: group['subtitle'] as String,
          profileImage: group['profileImage'] as String,
          date: group['date'] as String,
          section: ChoseContainerSection.group,
        );
      }).toList(),
    );
  }
}


