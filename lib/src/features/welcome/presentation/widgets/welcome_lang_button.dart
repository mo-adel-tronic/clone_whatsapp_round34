import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:clone_whatsapp_round34/src/features/welcome/presentation/lang_options_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeLangButton extends StatelessWidget {
  const WelcomeLangButton({super.key});

  showLanguages(BuildContext context) {
    final current = context.read<LanguageCubit>().state;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20.h),
              // Add language options here
              ...List.generate(
                langOptions.length,
                (index) {
                  final lang = langOptions[index];
                  return ListTile(
                    title: Text(lang['label']!),
                    trailing: current.languageCode == lang['languageCode']
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : null,
                    onTap: () {
                      context
                          .read<LanguageCubit>()
                          .setLanguage(lang['languageCode']!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),  // Add more languages as needed
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: () => showLanguages(context),
        borderRadius: BorderRadius.circular(20.r),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.0.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              BlocBuilder<LanguageCubit, Locale>(
                builder: (context, locale) {
                  final label = langOptions
                      .firstWhere(
                          (lang) => lang['languageCode'] == locale.languageCode,
                          orElse: () => langOptions[0])['label']!;
                  return Text(
                    label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                },
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
