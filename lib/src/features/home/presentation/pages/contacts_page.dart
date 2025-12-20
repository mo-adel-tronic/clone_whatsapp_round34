import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  /// دالة التعامل مع الضغط على مستخدم
  Future<void> _onContactTap(String userId, String userName, String? userImage) async {
    setState(() => _isLoading = true);

    try {
      // 1. استدعاء دالة SQL الذكية لجلب أو إنشاء الغرفة
      final roomId = await _supabase.rpc('create_or_get_chat', params: {
        'other_user_id': userId,
      });

      if (!mounted) return;

      // 2. الانتقال لصفحة الشات مع البيانات
      Navigator.pushReplacementNamed( // Replacement عشان لما يرجع يروح للـ Home مش للـ Contacts
        context,
        RoutesName.chat,
        arguments: {
          'roomId': roomId,
          'friendName': userName,
          'friendImage': userImage,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting chat: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myId = _supabase.auth.currentUser?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // عرض مؤشر تحميل فوق الشاشة إذا كنا ننشئ غرفة
      body: Stack(
        children: [
          // 1. قائمة المستخدمين
          FutureBuilder<List<Map<String, dynamic>>>(
            // نجلب كل المستخدمين ما عدا "أنا"
            future: _supabase.from('users').select().neq('id', myId!), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              final users = snapshot.data ?? [];

              if (users.isEmpty) {
                return const Center(child: Text("No contacts found."));
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final name = user['username'] ?? 'Unknown';
                  final image = user['avatar_url'];
                  final status = user['status'] ?? 'Hey there! I am using WhatsApp.';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: image != null ? NetworkImage(image) : null,
                      child: image == null ? const Icon(Icons.person) : null,
                    ),
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(status, maxLines: 1, overflow: TextOverflow.ellipsis),
                    onTap: () => _onContactTap(user['id'], name, image),
                  );
                },
              );
            },
          ),

          // 2. لودينج شفاف عند الضغط
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}