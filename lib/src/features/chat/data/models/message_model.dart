import 'package:clone_whatsapp_round34/src/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.content,
    required super.senderId,
    required super.createdAt,
    super.isRead = false,
    super.type = 'text',
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'] ?? '',
      senderId: json['sender_id'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      isRead: json['is_read'] ?? false,
      type: json['message_type'] ?? 'text',
    );
  }
}