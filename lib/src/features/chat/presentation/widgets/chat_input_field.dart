import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/chat_event.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/widgets/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final String roomId;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.roomId,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiShowing = false;

  @override
  void initState() {
    super.initState();
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

  void _toggleEmojiKeyboard(BuildContext context) {
    if (_isEmojiShowing) {
      FocusScope.of(context).requestFocus(_focusNode);
    } else {
      _focusNode.unfocus();
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        setState(() {
          _isEmojiShowing = true;
        });
      });
    }
  }

  void _openAttachments(BuildContext context) {
    _focusNode.unfocus();
    setState(() {
      _isEmojiShowing = false;
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
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
                _buildAttachmentTile(
                    context, Icons.insert_drive_file, "Document", Colors.deepPurple,
                    () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenDocumentEvent());
                }),
                _buildAttachmentTile(
                    context, Icons.camera_alt, "Camera", Colors.red, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenCameraEvent());
                }),
                _buildAttachmentTile(
                    context, Icons.photo, "Gallery", Colors.pink, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenGalleryEvent());
                }),
                _buildAttachmentTile(
                    context, Icons.audiotrack, "Audio", Colors.orange, () {
                  Navigator.of(context).pop();
                  // TODO: Handle Audio Pick Event
                }),
                _buildAttachmentTile(
                    context, Icons.location_on, "Location", Colors.green, () {
                  Navigator.of(context).pop();
                  context.read<ChatBloc>().add(OpenLocationEvent());
                }),
                _buildAttachmentTile(
                    context, Icons.currency_rupee, "Pay", Colors.teal, () {
                  Navigator.of(context).pop();
                  // TODO: Handle Payment
                }),
                _buildAttachmentTile(
                    context, Icons.person, "Contact", Colors.blue, () {
                  Navigator.of(context).pop();
                  // TODO: Handle Contact
                }),
                _buildAttachmentTile(
                    context, Icons.poll, "Poll", Colors.blueAccent, () {
                  Navigator.of(context).pop();
                  // TODO: Handle Poll
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentTile(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onTap) {
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
        Text(label,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => _toggleEmojiKeyboard(context),
                        icon: Icon(
                          _isEmojiShowing
                              ? Icons.keyboard_rounded
                              : Icons.emoji_emotions_outlined,
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
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              context.read<ChatBloc>().add(TypingEvent(value));
                            },
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
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => _openAttachments(context),
                        icon: const Icon(Icons.attach_file, color: Colors.grey),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.read<ChatBloc>().add(OpenCameraEvent());
                        },
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              //  تعديل هام: تمرير roomId لزر الإرسال
              SendButton(
                controller: widget.controller,
                roomId: widget.roomId, //  تأكد من تحديث SendButton لاستقبال هذا المتغير
              ),
            ],
          ),
          if (_isEmojiShowing)
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: Container(
                color: Colors.grey[100],
                alignment: Alignment.center,
                child: Text(
                  "Emoji Panel Placeholder",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}