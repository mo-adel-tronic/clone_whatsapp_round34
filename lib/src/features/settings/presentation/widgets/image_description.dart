import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:flutter/material.dart';

class ImageDescription extends StatelessWidget {

  const ImageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   
    return Column(
      children: [
        const SizedBox(height: 35),
         Container(
            constraints: const BoxConstraints(maxHeight: 140, maxWidth: 330),
            child: Image.asset('assets/images/Linked_device.png', fit: BoxFit.contain),
          ),
        
        const SizedBox(height: 18),
         Column(
            children: [
              Text(S.of(context).linked_desc1,
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 6),
              Text(S.of(context).linked_desc2,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        
        const SizedBox(height: 22),
      ],
    );
  }
}

