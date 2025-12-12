// lib/src/features/calls/presentation/widgets/call_list_item.dart

import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_color.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

class CallListItem extends StatelessWidget {
  final CallModel call;
  final VoidCallback? onTap;

  const CallListItem({
    super.key,
    required this.call,
    this.onTap,
  });

  Color get _arrowColor =>
      call.isIncoming ? AppColors.success : AppColors.error;

  IconData get _arrowIcon =>
      call.isIncoming ? Icons.call_made_rounded : Icons.call_received_rounded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasImage = call.avatarUrl != null && call.avatarUrl!.isNotEmpty;

    final nameColor = call.isMissed
        ? AppColors.error
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);
    final subtitleColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    //  Avatar (network image with fallback initial)
    Widget buildAvatar() {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        child: ClipOval(
          child: (!hasImage)
              ? Image.asset(
                  'assets/images/calls/avatar_default_img.jpeg',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  call.avatarUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    //  if network image fails
                    print(error);
                    return Image.asset(
                      'assets/images/calls/avatar_default_img.jpeg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
        ),
      );

      /*return CircleAvatar(
        radius: 24,
        // backgroundColor: AppColors.surfaceLight.withOpacity(isDark ? 0.2 : 0.7),

        //Problem : Can't Get the avatar image?
        backgroundImage: hasImage ? NetworkImage(call.avatarUrl!) : null,
        child: !hasImage
            ? Text(
                call.name.isNotEmpty ? call.name[0].toUpperCase() : '?',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.bold,
                ),
              )
            :
            //null if hasImage is true
          null
      );*/
    }

    return ListTile(
      onTap: onTap, // tap the row : go to voice / video page
      // leading: hasImage ? Image.network(call.avatarUrl!) : buildAvatar(),
      leading: buildAvatar(),
      title: //2 childern (text + verify icon if exist)
          Row(
        children: [
          Text(
            call.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: nameColor,
            ),
          ),
          if (call.isVerified)
            Icon(
              Icons.verified,
              size: 18,
              color: Colors.green.shade400,
            ),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(
            _arrowIcon,
            size: 18,
            color: _arrowColor,
          ),
          const SizedBox(width: 6),

          //ex:30 min ago ,...
          Flexible(
            child: Text(
              call.timeLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: subtitleColor,
              ),
            ),
          ),
        ],
      ),

      //  trailing icons (go to voice or video call pages)
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          call.isVideoCall ? Icons.videocam_rounded : Icons.call_rounded,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
