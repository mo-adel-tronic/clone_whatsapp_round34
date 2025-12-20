import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:clone_whatsapp_round34/src/features/home/data/models/chat_preview_model.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/chose_container_section.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/container_home_widget.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/pages/chat_page.dart'; // ✅ تأكد من استيراد صفحة الشات
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsList extends StatefulWidget {
  final String searchText;

  const ChatsList({
    super.key,
    this.searchText = "",
  });

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  // متغير لتخزين تيار البيانات
  late Stream<List<ChatPreviewModel>> _chatsStream;

  @override
  void initState() {
    super.initState();
    _chatsStream = _setupChatsStream();
  }

  Stream<List<ChatPreviewModel>> _setupChatsStream() {
    // 1. نستمع لأي تغيير في جدول الغرف (rooms)
    // التغيير يحدث بفضل الـ Trigger الذي وضعناه في قاعدة البيانات
    return Supabase.instance.client
        .from('rooms')
        .stream(primaryKey: ['id'])
        .order('last_message_time', ascending: false) // ✅ مهم جداً لالتقاط التحديث الزمني
        .asyncMap((_) async {
          // 2. بمجرد التقاط إشارة تغيير، نقوم بجلب البيانات كاملة ومحدثة عبر الدالة RPC
          // تأكد أنك قمت بإنشاء الدالة get_my_chats_v1 في قاعدة البيانات
          final data = await Supabase.instance.client.rpc('get_my_chats_v1');
          
          // 3. تحويل البيانات القادمة (JSON) إلى الموديل الخاص بنا
          final List<dynamic> response = data as List<dynamic>;
          return response.map((json) => ChatPreviewModel.fromJson(json)).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatPreviewModel>>(
      stream: _chatsStream,
      builder: (context, snapshot) {
        // --- حالة التحميل ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- حالة وجود خطأ ---
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'حدث خطأ في جلب المحادثات\n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // --- حالة عدم وجود بيانات (القائمة فارغة) ---
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد محادثات بعد\nابدأ محادثة جديدة من الزر العائم',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        // البيانات الأصلية القادمة من السيرفر
        final allChats = snapshot.data!;

        // --- منطق الفلترة (Search) ---
        // نقوم بفلترة القائمة محلياً بناءً على النص المكتوب في شريط البحث
        final filteredChats = allChats.where((chat) {
          return chat.userName.toLowerCase().contains(widget.searchText.toLowerCase());
        }).toList();

        // --- إذا كان البحث لا يطابق أي نتيجة ---
        if (filteredChats.isEmpty) {
          return const Center(child: Text('لم يتم العثور على نتائج'));
        }

        // --- بناء القائمة النهائية ---
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: filteredChats.length,
          itemBuilder: (context, index) {
            final chat = filteredChats[index];

            return InkWell(
              onTap: () {
                // ✅ استخدام التنقل المباشر لضمان تمرير البيانات لصفحة الشات التي برمجناها
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      roomId: chat.id,
                      friendName: chat.userName,
                      friendImage: chat.profileImage,
                      friendId: chat.friendId,
                    ),
                  ),
                );
              },
              child: ContainerHomeWidget(
                userName: chat.userName,
                subtitle: chat.subtitle,
                // نضع صورة افتراضية في حالة عدم وجود صورة للشخص
                profileImage: chat.profileImage ?? 
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                date: formatDate(chat.date), // تأكد من وجود دالة formatDate في utils
                isSent: chat.isSent,
                isSeen: chat.isSeen, // ✅ ستعمل الآن وتتحول للأزرق بفضل الـ Trigger
                unreadMessage: chat.unreadCount > 0 ? chat.unreadCount.toString() : null,
                
                section: ChoseContainerSection.chat,
              ),
            );
          },
        );
      },
    );
  }
}