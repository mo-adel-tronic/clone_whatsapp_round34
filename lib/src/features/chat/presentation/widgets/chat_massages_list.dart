import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_state.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_theme.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is! ChatLoadedState) {
          return const SizedBox();
        }

        final messages = state.messages;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          itemCount: messages.length,
          reverse: true, // show newest at bottom (like WhatsApp)
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // because reverse: true, index 0 is the last message in messages list
            final msg = messages[messages.length - 1 - index];

            final isMe = msg["isMe"] == true;
            final bgColor = isMe
                ? AppTheme.lightTheme.colorScheme.secondary
                : AppTheme.lightTheme.colorScheme.surface;
            final textColor = isMe ? AppTheme.lightTheme.colorScheme.onSecondary : Colors.black87;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isMe ? 12 : 2),
                      bottomRight: Radius.circular(isMe ? 2 : 12),
                    ),
                  ),
                  child: Text(
                    msg["msg"] as String,
                    style: TextStyle(fontSize: 15, color: textColor),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}