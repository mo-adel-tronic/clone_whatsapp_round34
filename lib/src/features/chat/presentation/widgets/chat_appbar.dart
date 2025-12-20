import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:clone_whatsapp_round34/src/features/calls/domain/repositories/call_repository.dart';
import 'package:clone_whatsapp_round34/src/features/calls/presentation/pages/call_page.dart';
import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_theme.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String friendName;
  final String? friendImage;
  final String roomId;
  final String friendId;

  const ChatAppBar({
    super.key,
    required this.friendName,
    this.friendImage,
    required this.roomId,
    required this.friendId,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                friendImage != null ? NetworkImage(friendImage!) : null,
            child: friendImage == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(friendName,
                  style: const TextStyle(fontSize: 16, color: Colors.white)),
              const Text("Tap for info",
                  style: TextStyle(fontSize: 13, color: Colors.white70)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () async {
            try {
              // 1. إنشاء سجل المكالمة في الداتابيس
              final callRepo = CallRepository();
              // ملاحظة: نحتاج لبيانات المستخدم الحالي (اسمي وصورتي) لنرسلها للطرف الآخر
              // يمكن جلبها من Supabase Auth مؤقتاً أو من الـ User Bloc
              final myName = "Me"; // TODO: احصل على اسمك الحقيقي

              final callId = await callRepo.startCall(
                receiverId:
                    friendId,
                callerName: myName,
                callerAvatar: null,
                channelId: roomId, // نستخدم ID الغرفة كقناة للمكالمة
              );
              
              await callRepo.startCall(
                receiverId:
                    friendId,
                callerName: myName,
                callerAvatar: null,
                channelId: roomId, // نستخدم ID الغرفة كقناة للمكالمة
              );

              if (!context.mounted) return;
              // 2. الذهاب لصفحة الفيديو وانتظار الرد
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CallPage(channelName: roomId, userName: friendName, callId: callId),
                ),
              );
            } catch (e) {
              AppLogger.e("Error starting call: $e");
            }
          },
        ),
        Icon(Icons.videocam, color: Colors.white),
        SizedBox(width: 15),
        Icon(Icons.call, color: Colors.white),
        SizedBox(width: 15),
        Icon(Icons.more_vert, color: Colors.white),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
