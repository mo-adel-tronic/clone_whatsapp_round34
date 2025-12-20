import 'package:clone_whatsapp_round34/src/features/home/domain/entities/chat_preview_entity.dart';

class ChatPreviewModel extends ChatPreviewEntity {
  const ChatPreviewModel({
    required super.id,
    required super.userName,
    required super.friendId,
    required super.subtitle,
    super.profileImage,
    super.date,
    super.isSent = false,
    super.isSeen = false,
    super.unreadCount = 0,
  });

  factory ChatPreviewModel.fromJson(Map<String, dynamic> json) {
    return ChatPreviewModel(
      id: json['room_id'],
      userName: json['friend_name'] ?? 'Unknown',
      friendId: json['friend_id'] ?? '',
      subtitle: json['last_message'] ?? '',
      profileImage: json['friend_image'],
      date: json['last_message_time'] != null 
          ? DateTime.parse(json['last_message_time']).toLocal() 
          : null,
      isSent: json['is_sent'] ?? false,
      isSeen: json['is_seen'] ?? false,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
    );
  }
}