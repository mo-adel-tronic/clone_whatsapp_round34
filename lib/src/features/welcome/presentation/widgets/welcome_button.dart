import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.login);
        },
        child: Text((S.of(context).welcome_btn).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}