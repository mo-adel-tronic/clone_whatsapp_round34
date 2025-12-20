import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:flutter/material.dart';

class DeviceSection extends StatelessWidget {
 
  const DeviceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primary = theme.colorScheme.primary;
    final Color text = theme.textTheme.bodyMedium!.color!;
    
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Divider(color: Theme.of(context).colorScheme.surface),
            const SizedBox(height: 16),
            Text(S.of(context).linked_status,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: text,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 8),
            Text(S.of(context).linked_status_text, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 14),
          ],
        ),
       Row(
        children: [
           Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: .12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.window,
                  color: primary,
                ))),
         const SizedBox(width: 12),

            // DEVICE TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).linked_device_name,
                    style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.of(context).linked_device_active,
                    style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),

            Icon(Icons.keyboard_arrow_right, color: text),
        ],
       )
      ],
    );
  }
}
