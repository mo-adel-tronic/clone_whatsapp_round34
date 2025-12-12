import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_theme.dart';

class SendButton extends StatefulWidget {
  final TextEditingController controller;
  const SendButton({super.key, required this.controller});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool _isLocallyRecording = false;
  // For demo we simulate a file path after stop
  String? _lastRecordedFakePath;

  void _startLocalRecording() {
    setState(() => _isLocallyRecording = true);
    context.read<ChatBloc>().add(StartRecordingEvent());
    // TODO: call actual recorder service.start()
  }

  void _stopLocalRecording() {
    setState(() => _isLocallyRecording = false);
    context.read<ChatBloc>().add(StopRecordingEvent());
    // simulate file path for demo
    _lastRecordedFakePath = '/tmp/voice${DateTime.now().millisecondsSinceEpoch}.aac';
  }

  void _cancelLocalRecording() {
    setState(() => _isLocallyRecording = false);
    _lastRecordedFakePath = null;
    context.read<ChatBloc>().add(CancelRecordingEvent());
    // TODO: recorder service.cancel()
  }

  Future<void> _showAfterRecordOptions() async {
    if (_lastRecordedFakePath == null) return;

    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.send),
                title: const Text('Send'),
                onTap: () => Navigator.of(context).pop('send'),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () => Navigator.of(context).pop('delete'),
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Close'),
                onTap: () => Navigator.of(context).pop('close'),
              ),
            ],
          ),
        );
      },
    );

    if (action == 'send') {
      context.read<ChatBloc>().add(SendRecordingEvent(_lastRecordedFakePath!));
      _lastRecordedFakePath = null;
    } else if (action == 'delete') {
      context.read<ChatBloc>().add(DeleteRecordingEvent());
      _lastRecordedFakePath = null;
    }
  }

  void _sendText() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(SendMessageEvent(text));
    widget.controller.clear();
    context.read<ChatBloc>().add(TypingEvent(""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        bool isTyping = false;
        bool isRecording = false;
        if (state is ChatLoadedState) {
          isTyping = state.currentText.isNotEmpty;
          isRecording = state.isRecording;
        }

        final showAsRecording = isRecording || _isLocallyRecording;

        return GestureDetector(
          onTap: () async {
            if (isTyping) {
              _sendText();
            } else {
              // quick tap when not typing -> short recording demo
              _startLocalRecording();
              await Future.delayed(const Duration(seconds: 2));
              if (_isLocallyRecording) {
                _stopLocalRecording();
                await _showAfterRecordOptions();
              }
            }
          },
          onLongPress: () {
            _startLocalRecording();
          },
          onLongPressUp: () async {
            if (_isLocallyRecording) {
              _stopLocalRecording();
              await _showAfterRecordOptions();
            }
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
              if (_isLocallyRecording) {
                _cancelLocalRecording();
              }
            }
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: showAsRecording ? Colors.red : AppTheme.lightTheme.primaryColor,
            child: Icon(
              isTyping ? Icons.send : (showAsRecording ? Icons.stop : Icons.mic),
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 26,
            ),
          ),
        );
      },
    );
  }
}