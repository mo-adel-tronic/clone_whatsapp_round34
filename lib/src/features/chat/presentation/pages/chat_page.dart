import 'package:clone_whatsapp_round34/src/core/theme/theme.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_state.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_appbar.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/chat_massages_list.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/voice_recorde.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(),
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,

        appBar: const ChatAppBar(),

        body: Stack(
  children: [
    Positioned.fill(child: Image.asset("assets/images/doodle_bg.png", fit: BoxFit.cover)),
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Column(
          children: [
            const Expanded(child: ChatMessagesList()),
            // if recording, show overlay inside Stack using Positioned (we used VoiceRecordOverlay)
            ChatInputField(controller: _controller),
          ],
        );
      },
    ),
    // place overlay on top of everything when recording:
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final isRecording = state is ChatLoadedState ? state.isRecording : false;
        if (!isRecording) return const SizedBox.shrink();
        return const VoiceRecordOverlay();
      },
    ),
  ],
)
,
      ),
    );
  }
}