class CallModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String bgImgUrl;
  final bool isVideoCall; // if true → video icon, false → phone icon
  final bool isIncoming; // true → green up arrow, false → red down arrow
  final bool isMissed; // missed calls can be red text, etc.
  final String timeLabel; // "10 minutes ago", "Yesterday"
  final bool isVerified;
  final String lastCallTime;
  // green verified badge

  const CallModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.bgImgUrl,
    required this.isVideoCall,
    required this.isIncoming,
    required this.isMissed,
    required this.timeLabel,
    required this.lastCallTime,
    this.isVerified = false,
  });
}
