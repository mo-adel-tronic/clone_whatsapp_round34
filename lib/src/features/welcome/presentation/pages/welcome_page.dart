import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/constants/constants.dart';
import 'package:clone_whatsapp_round34/src/features/welcome/presentation/widgets/welcome_button.dart';
import 'package:clone_whatsapp_round34/src/features/welcome/presentation/widgets/welcome_lang_button.dart';
import 'package:clone_whatsapp_round34/src/features/welcome/presentation/widgets/welcome_terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _welcomeImage(context),
            SizedBox(height: 40.h),
            _welcomeContent(context),
          ],
        ),
      ),
    );
  }

  Expanded _welcomeImage(BuildContext context) {
    return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.w,
              vertical: 10.h,
            ),
            child: Image.asset(
              AppImages.welcome,
              color: Theme.of(context).colorScheme.secondary,
            ),
          )),
    );
  }

  Expanded _welcomeContent(BuildContext context) {
    return Expanded(
            child: Column(
              children: [
                Text(
                  S.of(context).welcome_title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),

                const WelcomeTerms(),

                WelcomeButton(),

                SizedBox(height: 50.h),

                WelcomeLangButton(),
              ],
            ),
          );
  }
}
