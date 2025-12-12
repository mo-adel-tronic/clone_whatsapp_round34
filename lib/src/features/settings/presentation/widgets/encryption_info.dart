import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:flutter/material.dart';

class EncryptionInfo extends StatelessWidget {
  
  const EncryptionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color text = theme.textTheme.bodyMedium!.color!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lock_outline, size: 18, color: text),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13),
              children:  [
                TextSpan(text: S.of(context).linked_encryption1),
                TextSpan(
                  text: S.of(context).linked_encryption2,
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: S.of(context).linked_encryption3),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
