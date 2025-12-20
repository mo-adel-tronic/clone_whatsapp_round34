import 'package:clone_whatsapp_round34/src/features/chat/data/models/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<MessageModel> messages;
  final bool isRecording;

  ChatLoadedState({this.messages = const [], this.isRecording = false});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
