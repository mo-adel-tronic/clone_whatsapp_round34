import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import 'send_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // لاستخدام القياسات بشكل صحيح

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;

  const ChatInputField({super.key, required this.controller});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiShowing = false; // يتحكم في ظهور لوحة الإيموجي الوهمية (بدون حزمة)
  
  @override
  void initState() {
    super.initState();
    // عند التركيز على حقل النص، نعلم أن الكيبورد مفتوح
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isEmojiShowing = false;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // لتبديل بين وضع الكيبورد ووضع الإيموجي
  void _toggleEmojiKeyboard(BuildContext context) {
    if (_isEmojiShowing) {
      // إذا كانت لوحة الإيموجي مفتوحة -> افتح الكيبورد
      FocusScope.of(context).requestFocus(_focusNode);
    } else {
      // إذا كان الكيبورد مفتوحاً -> أغلقه وافتح لوحة الإيموجي
      _focusNode.unfocus();
      // تأخير بسيط لضمان إغلاق لوحة مفاتيح النظام
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        setState(() {
          _isEmojiShowing = true;
        });
      });
    }
  }

  // إضافة زر "Pay" و "Poll" للمرفقات لتطابق الصورة المرفقة
  void _openAttachments(BuildContext context) {
    // إغلاق أي لوحة مفتوحة قبل عرض المرفقات
    _focusNode.unfocus();
    setState(() {
      _isEmojiShowing = false;
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 10.w,
              childAspectRatio: 0.8,
              children: [
                _buildAttachmentTile(context, Icons.insert_drive_file, "Document", Colors.deepPurple, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenDocumentEvent());
                }),
                _buildAttachmentTile(context, Icons.camera_alt, "Camera", Colors.red, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenCameraEvent());
                }),
                _buildAttachmentTile(context, Icons.photo, "Gallery", Colors.pink, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenGalleryEvent());
                }),
                _buildAttachmentTile(context, Icons.audiotrack, "Audio", Colors.orange, () {
                  Navigator.of(context).pop();
                  // TODO: handle audio pick
                }),
                _buildAttachmentTile(context, Icons.location_on, "Location", Colors.green, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenLocationEvent());
                }),
                // إضافة زر Pay
                _buildAttachmentTile(context, Icons.currency_rupee, "Pay", Colors.teal, () {
                  Navigator.of(context).pop();
                  // TODO: handle Pay
                }),
                _buildAttachmentTile(context, Icons.person, "Contact", Colors.blue, () {
                  Navigator.of(context).pop();
                  // TODO: handle contact
                }),
                // إضافة زر Poll
                _buildAttachmentTile(context, Icons.poll, "Poll", Colors.blueAccent, () {
                  Navigator.of(context).pop();
                  // TODO: handle Poll
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentTile(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        Material(
          color: color.withOpacity(0.1),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 50.w,
              height: 50.w,
              child: Icon(icon, size: 28.w, color: color),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 6.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // زر الإيموجي/الكيبورد
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => _toggleEmojiKeyboard(context),
                        icon: Icon(
                          _isEmojiShowing 
                              ? Icons.keyboard_rounded // إذا كانت لوحة الإيموجي مفتوحة -> اعرض أيقونة الكيبورد
                              : Icons.emoji_emotions_outlined, // إذا كان الكيبورد مفتوحاً أو لا شيء مفتوح -> اعرض أيقونة الإيموجي
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 100.h),
                          child: TextField(
                            controller: widget.controller,
                            focusNode: _focusNode,
                            maxLines: null, // يسمح بالنزول لسطر جديد
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              context.read<ChatBloc>().add(TypingEvent(value));
                            },
                            // عند الضغط على حقل النص، تأكد من إغلاق لوحة الإيموجي
                            onTap: () {
                              if (_isEmojiShowing) {
                                setState(() {
                                  _isEmojiShowing = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Message",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // زر المرفقات
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => _openAttachments(context),
                        icon: const Icon(Icons.attach_file, color: Colors.grey),
                      ),
                      // زر الكاميرا السريع
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.read<ChatBloc>().add(OpenCameraEvent());
                          // TODO: هنا يجب فتح الكاميرا، تحتاج إلى حزمة مثل camera أو image_picker
                        },
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SendButton(controller: widget.controller),
            ],
          ),
          // مكان محاكاة لوحة الإيموجي (بدون حزمة)
          if (_isEmojiShowing)
            SizedBox(
              height: 250.h,
              width: double.infinity,
              // هذا هو المكان الذي يجب أن تضع فيه حزمة الإيموجي (مثل emoji_picker_flutter)
              // أو يمكنك عرض لوحة مفاتيح النظام التي تدعم الإيموجي بشكل أفضل.
              child: Container(
                color: Colors.grey[100],
                alignment: Alignment.center,
                child: Text(
                  "Emoji Panel Placeholder (No Package Used)",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}