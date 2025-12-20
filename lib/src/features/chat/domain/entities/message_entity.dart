import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final DateTime createdAt;
  final bool isRead;
  final String type; // text, image, audio

  const MessageEntity({
    required this.id,
    required this.content,
    required this.senderId,
    required this.createdAt,
    this.isRead = false,
    this.type = 'text',
  });

  @override
  List<Object?> get props => [id, content, senderId, createdAt, isRead, type];
}