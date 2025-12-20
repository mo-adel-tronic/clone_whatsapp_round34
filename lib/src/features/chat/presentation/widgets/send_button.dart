import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendButton extends StatefulWidget {
  final TextEditingController controller;
  final String roomId;

  const SendButton({
    super.key,
    required this.controller,
    required this.roomId,
  });

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool _isLocallyRecording = false;
  
  // دالة إرسال النص الحقيقية
  void _sendText() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatBloc>().add(
      SendMessageEvent(content: text, roomId: widget.roomId)
    );

    widget.controller.clear();
    // إيقاف مؤشر الكتابة (اختياري)
    // context.read<ChatBloc>().add(TypingEvent("")); 
  }

  // --- دوال التسجيل (سنتركها كما هي حالياً حتى نطبق الـ Storage) ---
  void _startLocalRecording() {
    setState(() => _isLocallyRecording = true);
    // context.read<ChatBloc>().add(StartRecordingEvent());
  }

  void _stopLocalRecording() {
    setState(() => _isLocallyRecording = false);
    // context.read<ChatBloc>().add(StopRecordingEvent());
  }

  // void _cancelLocalRecording() {
  //   setState(() => _isLocallyRecording = false);
  //   // context.read<ChatBloc>().add(CancelRecordingEvent());
  // }

  @override
  Widget build(BuildContext context) {
    // نستمع لتغييرات الـ Bloc لمعرفة هل نكتب أم لا
    // ولكن بما أننا نستخدم Controller محلي، يمكننا الاعتماد عليه لتحديث الأيقونة
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        final isTyping = value.text.trim().isNotEmpty;
        final showAsRecording = !isTyping && _isLocallyRecording;

        return GestureDetector(
          onTap: () {
            if (isTyping) {
              _sendText(); // إرسال النص
            } else {
              // منطق الضغط السريع للتسجيل (يمكن تفعيله لاحقاً)
              print("Mic tapped - Start recording logic here");
            }
          },
          // منطق الضغط المطول للتسجيل
          onLongPress: () {
            if (!isTyping) _startLocalRecording();
          },
          onLongPressUp: () {
            if (_isLocallyRecording) _stopLocalRecording();
          },
          child: CircleAvatar(
            radius: 24, // حجم متناسق
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              isTyping 
                  ? Icons.send 
                  : (showAsRecording ? Icons.stop : Icons.mic),
              color: Colors.white,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}