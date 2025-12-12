import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(ChatLoadedState(
          messages: [
            {"msg": "Bro I have secret identity\nNo one does know about me!!", "isMe": false},
            {"msg": "What's Secret ??", "isMe": true},
            {"msg": "bro", "isMe": true},
            {"msg": "Hello", "isMe": false},
            {"msg": "Are you free now?", "isMe": true},
            {"msg": "Nope!\nWhat happen tell me!", "isMe": false},
            {"msg": "I can't tell you now!", "isMe": true},
            {"msg": "Ok\nCome to Parade at 11:00 AM", "isMe": false},
            {"msg": "Ok!", "isMe": true},
            {"msg": "Should I call you now ?", "isMe": false},
          ],
        )) {
    on<SendMessageEvent>(_onSendMessage);
    on<TypingEvent>(_onTyping);
    on<StartRecordingEvent>(_onStartRecording);
    on<StopRecordingEvent>(_onStopRecording);
    on<SendRecordingEvent>(_onSendRecording);
    on<DeleteRecordingEvent>(_onDeleteRecording);
    on<CancelRecordingEvent>(_onCancelRecording);
    // add handlers for attachments if needed
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    final updated = List<Map<String, dynamic>>.from(current.messages)
      ..add({"msg": event.message, "isMe": true});

    emit(current.copyWith(messages: updated, currentText: "", isTyping: false));
  }

  void _onTyping(TypingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    emit(current.copyWith(isTyping: event.currentText.isNotEmpty, currentText: event.currentText));
  }

  void _onStartRecording(StartRecordingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    emit(current.copyWith(isRecording: true, recordingPath: null));
    // TODO: call recorder service to actually start recording
  }

  void _onStopRecording(StopRecordingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    emit(current.copyWith(isRecording: false));
    // TODO: when recorder stops, service should provide filePath and you should dispatch SendRecordingEvent(filePath)
  }

  void _onSendRecording(SendRecordingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    final updated = List<Map<String, dynamic>>.from(current.messages)
      ..add({"msg": "[Voice message] ${event.filePath}", "isMe": true});
    emit(current.copyWith(messages: updated, recordingPath: null));
  }

  void _onDeleteRecording(DeleteRecordingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    emit(current.copyWith(isRecording: false, recordingPath: null));
    // TODO: instruct recorder service to delete temporary file if exists
  }

  void _onCancelRecording(CancelRecordingEvent event, Emitter<ChatState> emit) {
    final current = state as ChatLoadedState;
    emit(current.copyWith(isRecording: false, recordingPath: null));
    // TODO: cancel and remove file
  }
}
