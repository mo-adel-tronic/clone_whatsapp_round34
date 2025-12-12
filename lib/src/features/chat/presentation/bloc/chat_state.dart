abstract class ChatState {
  const ChatState();
}

class ChatLoadedState extends ChatState {
  final List<Map<String, dynamic>> messages;
  final bool isTyping;
  final String currentText;
  final bool isRecording;
  final String? recordingPath;

  const ChatLoadedState({
    required this.messages,
    this.isTyping = false,
    this.currentText = "",
    this.isRecording = false,
    this.recordingPath,
  });

  ChatLoadedState copyWith({
    List<Map<String, dynamic>>? messages,
    bool? isTyping,
    String? currentText,
    bool? isRecording,
    String? recordingPath,
  }) {
    return ChatLoadedState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      currentText: currentText ?? this.currentText,
      isRecording: isRecording ?? this.isRecording,
      recordingPath: recordingPath ?? this.recordingPath,
    );
  }
}
