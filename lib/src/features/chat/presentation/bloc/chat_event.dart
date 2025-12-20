abstract class ChatEvent {}

// حدث إرسال رسالة نصية
class SendMessageEvent extends ChatEvent {
  final String content;
  final String roomId;
  SendMessageEvent({required this.content, required this.roomId});
}

// حدث لبدء الاستماع للرسائل في غرفة معينة
class LoadMessagesEvent extends ChatEvent {
  final String roomId;
  LoadMessagesEvent(this.roomId);
}

class MarkMessagesAsReadEvent extends ChatEvent {
  final String roomId;
  MarkMessagesAsReadEvent(this.roomId);
}

// ********************************************

class TypingEvent extends ChatEvent {
  final String currentText;
  TypingEvent(this.currentText);
}

// Recording events
class StartRecordingEvent extends ChatEvent {}
class StopRecordingEvent extends ChatEvent {}
class CancelRecordingEvent extends ChatEvent {}
class SendRecordingEvent extends ChatEvent {
  final String filePath;
  SendRecordingEvent(this.filePath);
}
class DeleteRecordingEvent extends ChatEvent {}

// Attachment / UI events (can be expanded)
class OpenCameraEvent extends ChatEvent {}
class OpenGalleryEvent extends ChatEvent {}
class OpenDocumentEvent extends ChatEvent {}
class OpenLocationEvent extends ChatEvent {}
class OpenEmojiPickerEvent extends ChatEvent {}
