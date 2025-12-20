import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTerms extends StatelessWidget {
  const WelcomeTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 20.h,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: S.of(context).policy_read,
                      style: Theme.of(context).textTheme.labelLarge,
                      children: [
                        TextSpan(
                          text: S.of(context).policy_privacy,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        TextSpan(
                          text: S.of(context).policy_tap,
                        ),
                        TextSpan(
                          text: S.of(context).policy_terms,
                           style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                );
  }
}