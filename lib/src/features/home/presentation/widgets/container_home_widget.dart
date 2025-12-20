import 'package:clone_whatsapp_round34/src/core/theme/app_color.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/chose_container_section.dart';
import 'package:flutter/material.dart';

class ContainerHomeWidget extends StatelessWidget {
  final ChoseContainerSection section;
  final String profileImage;
  final String userName;
  final String subtitle;
  final String? date;
  final String? unreadMessage;
  final bool? isVideoCall;
  final bool? isAnsewrCall;
  final bool? isSent;
  final bool? isSeen;

  const ContainerHomeWidget({
    super.key,
    required this.section,
    required this.userName,
    required this.subtitle,
    this.date,
    this.unreadMessage,
    this.isVideoCall,
    this.isAnsewrCall,
    required this.profileImage,
    this.isSent, this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            // Avatar with fixed size
            SizedBox(
              width: 52,
              height: 52,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: profileImage.isNotEmpty
                    ? (profileImage.startsWith('http')
                        ? Image.network(profileImage, fit: BoxFit.cover)
                        : Image.asset(profileImage, fit: BoxFit.cover))
                    : Container(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(width: 10),

            // LEFT SIDE (TEXT + ICONS) — make flexible so right side can fit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User Name
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Subtitle Row
                  Row(
                    children: [
                      _buildLeftIcon(),
                      const SizedBox(width: 6),
                      // Subtitle should be flexible and ellipsize if too long
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // RIGHT SIDE (DATE + UNREAD MESSAGE + SETTINGS ICONS)
            const SizedBox(width: 8),
            _buildRightSide()
          ],
        ),
      ),
    );
  }

  // ------------------------
  // LEFT ICON HANDLER
  // ------------------------
  Widget _buildLeftIcon() {
    switch (section) {
case ChoseContainerSection.chat:
  return isSent == true
      ? Icon(
          Icons.done_all,
          color: isSeen == true ? Colors.blueAccent : Colors.grey,
        )
      : const SizedBox.shrink();     
     case ChoseContainerSection.group:
        return Text("$userName:");

      case ChoseContainerSection.status:
        return const SizedBox(); // بدل NULL

      case ChoseContainerSection.calls:
        return Icon(isAnsewrCall == true ? Icons.call_made : Icons.call_missed,
            size: 22);
      case ChoseContainerSection.settings:
        return const SizedBox();
    }
  }

  // ------------------------
  // RIGHT SIDE HANDLER
  // ------------------------
  Widget _buildRightSide() {
    switch (section) {
      // ---------------- CHAT CASE ----------------
      case ChoseContainerSection.chat:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (date != null) Text(date!), // التاريخ

            const SizedBox(height: 8),

            if (unreadMessage != null)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    unreadMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        );
      case ChoseContainerSection.group:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (date != null) Text(date!), // التاريخ

            const SizedBox(height: 8),

            if (unreadMessage != null)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    unreadMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        );

      // ---------------- STATUS CASE ----------------
      case ChoseContainerSection.status:
        return const SizedBox(); // لا تاريخ ولا unread ولا icons

      // ---------------- CALLS CASE ----------------
      case ChoseContainerSection.calls:
        return Icon(isVideoCall == true ? Icons.videocam : Icons.call,
            size: 22); // مثال

      // ---------------- SETTINGS CASE ----------------
      case ChoseContainerSection.settings:
        return Row(
          children: const [
            Icon(Icons.qr_code),
            SizedBox(width: 10),
            Icon(Icons.keyboard_arrow_down),
          ],
        );
    }
  }
}
