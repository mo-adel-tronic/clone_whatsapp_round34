import 'package:clone_whatsapp_round34/src/features/chat/data/models/message_model.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    // نحصل على ID المستخدم الحالي لتمييز الرسائل (مرسلة مني أم من الطرف الآخر)
    final myId = Supabase.instance.client.auth.currentUser?.id;

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        // حالة التحميل
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // حالة عرض البيانات
        if (state is ChatLoadedState) {
          final messages = state.messages;

          // إذا كانت القائمة فارغة
          if (messages.isEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Say Hello! 👋",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: messages.length,
            reverse: true, // الرسائل الأحدث تكون في الأسفل
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final MessageModel msg = messages[index];
              final isMe = msg.senderId == myId;

              // تحديد الألوان بناءً على المرسل
              final bgColor = isMe
                  ? const Color(0xFFE7FFDB) // لون واتساب للأخضر الفاتح
                  : Colors.white;
              
              const textColor = Colors.black87;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isMe ? 12 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min, // مهم لكي لا يأخذ عرض كامل
                      children: [
                        // محتوى الرسالة
                        Text(
                          msg.content,
                          style: const TextStyle(fontSize: 16, color: textColor),
                        ),
                        const SizedBox(height: 2),
                        // الوقت وعلامة الصح
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(msg.createdAt),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 4),
                              Icon(
                                msg.isRead ? Icons.done_all : Icons.done,
                                size: 16,
                                color: msg.isRead ? Colors.blue : Colors.grey,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}