abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  SendMessageEvent(this.message);
}

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
