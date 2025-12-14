import '../data/models/notification_settings.dart';

class NotificationController {
  final NotificationSettings settings = NotificationSettings();

  void toggleAll(bool value) {
    settings.enabled = value;
    settings.messageTone = value;
    settings.groupNotification = value;
    settings.callTone = value;
    settings.vibration = value;
    settings.preview = value;
  }

  void toggleMessage(bool v) => settings.messageTone = v;
  void toggleGroup(bool v) => settings.groupNotification = v;
  void toggleCall(bool v) => settings.callTone = v;
  void toggleVibration(bool v) => settings.vibration = v;
  void togglePreview(bool v) => settings.preview = v;
}
