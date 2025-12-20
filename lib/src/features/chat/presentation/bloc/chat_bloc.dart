import 'package:clone_whatsapp_round34/src/features/chat/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  ChatBloc() : super(ChatInitial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkMessagesAsReadEvent>(_onMarkAsRead);
    on<TypingEvent>(_onTyping);
  }

  // Handle typing events (no-op for now). This prevents `add` calls failing
  // when the UI emits `TypingEvent`. You can expand this to broadcast
  // typing presence via Supabase realtime or update a typing state.
  Future<void> _onTyping(TypingEvent event, Emitter<ChatState> emit) async {
    // Currently we don't change the ChatState for typing updates.
    // If desired, emit a transient state here or notify server of typing.
    return;
  }

  // 1. الاستماع للرسائل (Real-time)
  Future<void> _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    // نستخدم emit.forEach للاستماع للـ Stream وتحديث الحالة تلقائياً
    await emit.forEach(
      _supabase
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('room_id', event.roomId)
          .order('created_at', ascending: false), // الأحدث أولاً
      onData: (List<Map<String, dynamic>> data) {
        final messages = data.map((e) => MessageModel.fromJson(e)).toList();
        return ChatLoadedState(messages: messages);
      },
      onError: (error, stackTrace) {
        return ChatError("Failed to load messages: $error");
      },
    );
  }

  // 2. إرسال رسالة
  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (event.content.trim().isEmpty) return;

    try {
      final myId = _supabase.auth.currentUser!.id;

      // أ) إدراج الرسالة في الجدول
      await _supabase.from('messages').insert({
        'room_id': event.roomId,
        'sender_id': myId,
        'content': event.content,
        'message_type': 'text',
        'created_at': DateTime.now().toIso8601String(),
      });

      // ب) تحديث آخر رسالة في الغرفة (ليظهر في الصفحة الرئيسية)
      await _supabase.from('rooms').update({
        'last_message': event.content,
        'last_message_time': DateTime.now().toIso8601String(),
      }).eq('id', event.roomId);

    } catch (e) {
      // يمكن معالجة الخطأ هنا (مثلاً إظهار SnackBar)
      print("Error sending message: $e");
    }
  }

  //  دالة تنفيذ التحديث في قاعدة البيانات
  Future<void> _onMarkAsRead(MarkMessagesAsReadEvent event, Emitter<ChatState> emit) async {
    final myId = _supabase.auth.currentUser?.id;
    
    try {
      await _supabase.from('messages').update({
        'is_read': true
      }).match({
        'room_id': event.roomId,
        'is_read': false, // نحدث فقط غير المقروء
      }).neq('sender_id', myId!); // ⛔️ لا تعلم رسائلي أنا كمقروءة (شرط مهم)
    } catch (e) {
      print("Error marking as read: $e");
    }
  }
}