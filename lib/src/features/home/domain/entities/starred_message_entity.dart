class StarredMessageEntity {
  final String senderName;
  final String messageContent;
  final String date;
  final String avatarUrl; 

  const StarredMessageEntity({
    required this.senderName,
    required this.messageContent,
    required this.date,
    this.avatarUrl = '', 
  });
}