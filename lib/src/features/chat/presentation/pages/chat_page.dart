import 'package:clone_whatsapp_round34/src/core/theme/theme.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_event.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_state.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_appbar.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_massages_list.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/voice_recorde.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String friendName;
  final String? friendImage;
  final String friendId;

  const ChatPage({
    super.key, 
    required this.roomId, 
    required this.friendName,
    this.friendImage,
    required this.friendId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc()..add(LoadMessagesEvent(widget.roomId)),
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: ChatAppBar(
          roomId: widget.roomId,
          friendName: widget.friendName,
          friendImage: widget.friendImage,
          friendId: widget.friendId,
        ),

        body: Stack(
          children: [
            Positioned.fill(
                child: Image.asset("assets/images/doodle_bg.png", fit: BoxFit.cover)),
            
            Column(
              children: [
                const Expanded(child: ChatMessagesList()),
                ChatInputField(
                  controller: _controller, 
                  roomId: widget.roomId, 
                ),
              ],
            ),

            // Voice Overlay Logic (كما هو)
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                final isRecording = state is ChatLoadedState ? state.isRecording : false;
                if (!isRecording) return const SizedBox.shrink();
                return const VoiceRecordOverlay();
              },
            ),
          ],
        ),
      ),
    );
  }
}