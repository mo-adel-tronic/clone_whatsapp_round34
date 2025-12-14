class NotificationSettings {
  bool enabled;
  bool messageTone;
  bool groupNotification;
  bool callTone;
  bool vibration;
  bool preview;

  NotificationSettings({
    this.enabled = true,
    this.messageTone = true,
    this.groupNotification = true,
    this.callTone = true,
    this.vibration = true,
    this.preview = true,
  });
}
