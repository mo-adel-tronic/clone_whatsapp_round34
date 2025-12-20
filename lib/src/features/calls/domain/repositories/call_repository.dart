import 'package:supabase_flutter/supabase_flutter.dart';

class CallRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 1. بدء مكالمة (للمتصل)
  Future<String> startCall({
    required String receiverId,
    required String callerName,
    required String? callerAvatar,
    required String channelId,
  }) async {
    final response = await _supabase.from('calls').insert({
      'caller_id': _supabase.auth.currentUser!.id,
      'receiver_id': receiverId,
      'caller_name': callerName,
      'caller_avatar': callerAvatar,
      'channel_id': channelId,
      'status': 'ringing', // الحالة المبدئية
    }).select().single();
    
    return response['id']; // نرجع الـ Call ID
  }

  // 2. تحديث حالة المكالمة (قبول/رفض/إنهاء)
  Future<void> updateCallStatus(String callId, String status) async {
    await _supabase.from('calls').update({
      'status': status
    }).eq('id', callId);
  }

 // 3. الاستماع للمكالمات الواردة (للمستقبل)
  Stream<List<Map<String, dynamic>>> listenToIncomingCalls() {
    final myId = _supabase.auth.currentUser?.id;
    
    return _supabase
        .from('calls')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', myId!) // ✅ الفلتر الأول (السيرفر) مقبول
        .order('created_at', ascending: false)
        .map((data) {
          // ✅ الفلتر الثاني (Client-Side) نقوم به هنا بلغة Dart
          // نأخذ القائمة القادمة ونحذف منها أي شيء حالته ليست ringing
          return data.where((call) => call['status'] == 'ringing').toList();
        });
  }
}