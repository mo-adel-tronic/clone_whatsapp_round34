// lib/src/features/calls/presentation/pages/calls_page.dart

import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_screen_args.dart';
import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/core/theme/app_color.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/dummy_calls.dart';

import '../widgets/call_list_item.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final scaffoldBackground =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final listBackground =
        isDark ? AppColors.chatBackgroundDark : AppColors.chatBackgroundLight;
    final titleColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final subtitleColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      // Floating button for new call
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          //Navigator.pushNamed(context, RoutesName.voiceCalls);
        },
        child: const Icon(Icons.add_call),
      ),

      body: Container(
        color: listBackground,
        child: ListView(
          children: [
            const SizedBox(height: 8),

            // "Create call link" tile
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.link, color: Colors.white),
              ),
              title: Text(
                'Create call link',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Share a link for your WhatsApp call',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                ),
              ),
              onTap: () {
                // TODO: later – create share link
              },
            ),

            //Child 2 in Parent List View
            // "Recent" label
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'Recent',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            //  Calls list (Child 3 in Parent List View)
            /*ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: dummyCalls.length,
              itemBuilder: (context, index) {
                final call = dummyCalls[index];
                return Container(
                  child: CallListItem(
                    call: call,
                    onTap: () {
                      if (call.isVideoCall) {
                        Navigator.of(context).pushNamed(RoutesName.videoCalls);
                      } else {
                        Navigator.of(context).pushNamed(RoutesName.voiceCalls);
                      }
                    },
                  ),
                );
              },
            ),*/

            //Another Way
            ...dummyCalls.map(
              (CallModel call) => CallListItem(
                call: call,
                onTap: () {
                  if (call.isVideoCall) {
                    Navigator.of(context).pushNamed(
                      RoutesName.videoCalls,
                      arguments: CallScreenArgs(
                        callId: call.id ?? "",
                        isVideo: true,
                        isCaller: true,
                        call: call,
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      RoutesName.voiceCalls,
                      arguments: CallScreenArgs(
                        callId: call.id ?? "", // or any string
                        isVideo: false,
                        isCaller: true,
                        call: call,
                      ),
                    );

                    // Navigator.of(context).pushNamed(
                    //   RoutesName.voiceCalls,
                    //   arguments: call,
                    // );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
