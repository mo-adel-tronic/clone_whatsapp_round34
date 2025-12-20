import 'package:equatable/equatable.dart';

class ChatPreviewEntity extends Equatable {
  final String id;
  final String userName;
  final String friendId;
  final String subtitle;
  final String? profileImage;
  final DateTime? date;
  final bool isSent;     
  final bool isSeen;      
  final int unreadCount;  

  const ChatPreviewEntity({
    required this.id,
    required this.userName,
    required this.friendId,
    required this.subtitle,
    this.profileImage,
    this.date,
    this.isSent = false,
    this.isSeen = false,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        friendId,
        subtitle,
        profileImage,
        date,
        isSent,
        isSeen,
        unreadCount,
      ];
}