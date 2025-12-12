import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:flutter/material.dart';

class LinkDeviceButton extends StatelessWidget {
  const LinkDeviceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
        ),
        child: Text(
          S.of(context).linked_btn,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
